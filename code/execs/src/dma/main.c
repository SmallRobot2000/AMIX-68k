#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <math.h>
#define XOSERA_BASE 0xFF1000

                        //*2 because 8 bit interface must be even address
#define XM_SYS_CTRL	    		0x00*4		//R /W+	Status flags, write to [15:8] inits PIXEL_X/Y, [3:0] VRAM write nibble mask
#define XM_INT_CTR	    		0x08*4		//R /W+	FPGA reconfigure, interrupt masking, interrupt status
#define XM_TIMER	    		0x01*4		//R /W+	Read 16-bit tenth millisecond timer (1/10,000 second), write 8-bit interval timer
#define XM_RD_XADD	    		0x09*4		//R /W+	XR register/address used for XM_XDATA read access
#define XM_WR_XADD	    		0x02*4		//R /W	XR register/address used for XM_XDATA write access
#define XM_XDATA	    		0x0A*4		//R+/W+	Read from XM_RD_XADDR or write to XM_WR_XADDR (and increment address by 1)
#define XM_RD_INCR	    		0x03*4		//R /W	increment value for XM_RD_ADDR read from XM_DATA/XM_DATA_2
#define XM_RD_ADDR	    		0x0B*4		//R /W+	VRAM address for reading from VRAM when XM_DATA/XM_DATA_2 is read
#define XM_WR_INCR	    		0x04*4		//R /W	increment value for XM_WR_ADDR on write to XM_DATA/XM_DATA_2
#define XM_WR_ADDR	    		0x0C*4		//R /W	VRAM address for writing to VRAM when XM_DATA/XM_DATA_2 is written
#define XM_DATA		    		0x05*4		//R+/W+	read/write VRAM word at XM_RD_ADDR/XM_WR_ADDR (and add XM_RD_INCR/XM_WR_INCR)
#define XM_DATA_2	    		0x0D*4		//R+/W+	2nd XM_DATA(to allow for 32-bit read/write access)
#define XM_PIXEL_X	    		0x06*4		//- /W+	X pixel sets WR_ADDR and nibble mask (also PIXEL_BASE for XM_SYS_CTRL write)
#define XM_PIXEL_Y	    		0x0E*4		//- /W+	Y pixel sets WR_ADDR and nibble mask (also PIXEL_WIDTH for XM_SYS_CTRL write)
#define XM_UART		    		0x07*4		//R+/W+	USB UART using FTDI chip in UPduino for additional 1 Mbps USB connection to PC [1]
#define XM_FEATUR	    		0x0F*4		//R /-	Feature bits
	

#define XR_VID_CTRL	             0x00     //R /W	Border color index and playfield color swap
#define XR_COPP_CTRL             0x01     //R /W	Display synchronized coprocessor ("copper") control
#define XR_AUD_CTRL	             0x02     //R /W	Audio channel DMA control
#define XR_SCANLINE	             0x03     //R /W+	Current display scanline / write triggers video interrupt
#define XR_VID_LEFT	             0x04     //R /W	Left edge start of active display window (normally 0)
#define XR_VID_RIGHT             0x05     //R /W	Right edge + 1 end of active display window (normally 640 or 848)
#define XR_POINTER_H             0x06     //- /W	pointer sprite H position (in native screen coordinates)
#define XR_POINTER_V             0x07     //- /W	pointer sprite V position (in native screen coordinates) and color select
                                //0x08-0x0F	XR_UNUSED_0x	- /-	Unused registers
#define XR_PA_GFX_CTRL	         0x10	    //R/W	playfield A graphics control
#define XR_PA_TILE_CTRL	         0x11	    //R/W	playfield A tile control
#define XR_PA_DISP_ADDR	         0x12	    //R/W	playfield A display VRAM start address (start of frame)
#define XR_PA_LINE_LEN	         0x13	    //R/W	playfield A display line width in words
#define XR_PA_HV_FSCALE	         0x14	    //R/W	playfield A horizontal and vertical fractional scaling
#define XR_PA_H_SCROLL	         0x15	    //R/W	playfield A horizontal fine scroll
#define XR_PA_V_SCROLL	         0x16	    //R/W	playfield A vertical repeat and tile fine scroll
#define XR_PA_LINE_ADDR	         0x17	    //-/W	playfield A scanline start address (start of next line)
#define XR_PB_GFX_CTRL	         0x18	    //R/W	playfield B graphics control
#define XR_PB_TILE_CTRL	         0x19	    //R/W	playfield B tile control
#define XR_PB_DISP_ADDR	         0x1A	    //R/W	playfield B display VRAM start address (start of frame)
#define XR_PB_LINE_LEN	         0x1B	    //R/W	playfield B display line width in words
#define XR_PB_HV_FSCALE	         0x1C	    //R/W	playfield B horizontal and vertical fractional scaling
#define XR_PB_H_SCROLL	         0x1D	    //R/W	playfield B horizontal fine scroll
#define XR_PB_V_SCROLL	         0x1E	    //R/W	playfield B horizontal repeat and tile fine scroll
#define XR_PB_LINE_ADDR	         0x1F	    //-/W	playfield B scanline start address (start of next line)


#define DMA_BASE       ((volatile uint16_t *)0xFF4000)  // Replace with actual DMA base address

// DMA registers offsets from base (word offsets, adjust if necessary)
#define DMAC_CMD_REG       0x0*2  // Command register
#define DMAC_STATUS_REG    0x1*2  // Status register
#define DMAC_CHAN_BASE     0x8*2  // Base offset of Channel 0 registers (example offset)
#define DMAC_CHAN_STRIDE   0x8*2  // Distance between consecutive channel regs

// Channel registers offsets (word offsets)
#define CHAN_SRC_ADDR_HIGH   0x0*2
#define CHAN_SRC_ADDR_LOW    0x1*2
#define CHAN_DST_ADDR_HIGH   0x2*2
#define CHAN_DST_ADDR_LOW    0x3*2
#define CHAN_LCNT_HIGH       0x4*2
#define CHAN_LCNT_LOW        0x5*2
#define CHAN_CONTROL         0x6*2

// Command Register values (example, set actual bits per datasheet)
#define DMAC_CMD_ENABLE      0x01
#define DMAC_CMD_START_CHAN0 0x10

// Control register flags for channel (example)
#define CHAN_CTRL_MEM_TO_MEM 0x0001
#define CHAN_CTRL_ENABLE     0x8000

// DMA address translation helper macros for 16-bit register interface
#define ADDR_HIGH(addr) ((uint16_t)(((uint32_t)(addr) >> 16) & 0xFFFF))
#define ADDR_LOW(addr)  ((uint16_t)((uint32_t)(addr) & 0xFFFF))

// Transfer count in bytes (words or bytes depending on chip configuration)
#define TRANSFER_SIZE  256
//Demo of xosera layer B
void __attribute__((noinline, optimize("O0"))) x_outw(uint16_t port, uint16_t dat)
{
    //Output to raw xosera port
    __asm__ volatile (
        "move.l %1, %%a0\n\t"           // load offset into a0
        "move.w %0, %%d0\n\t"           // load dat into d0
        "movep %%d0, ($0, %%a0)\n\t"  // movep.w d0, (a1, a0)
        :
        : "r"(dat), "r"(port + XOSERA_BASE)
        : "d0", "a0"
    );

    
}
uint16_t __attribute__((noinline, optimize("O0"))) x_inw(uint16_t port)
{
    uint16_t ret;
    __asm__ volatile (
        "move.l %1, %%a0\n\t"            /* Load base+port into a0 */
        "movep.w ($0, %%a0), %%d0\n\t"      /* movep word from (a0) to d0 */
        "move.w %%d0, %0\n\t"            /* Move d0 to ret */
        : "=r"(ret)
        : "r"((uint32_t)(port + XOSERA_BASE))
        : "d0", "a0"
    );
    return ret;
}
void xport_outw(uint16_t xport, uint16_t dat)
{
    x_outw(XM_WR_XADD, xport);

    x_outw(XM_XDATA, dat); //White square at 0,0
}
uint16_t xport_inw(uint16_t xport)
{
    x_outw(XM_RD_XADD, xport);

    return x_inw(XM_XDATA);
}
void delay(unsigned int count) {
    while (count--) {
        // Prevent optimization of empty loop
        asm volatile("nop");
    }
}
extern inline void asm_STI(void) {
    __asm__ volatile ("move.w #0x2700, %%sr" ::: "memory");
}

extern inline void asm_CLI(void) {
    __asm__ volatile ("move.w #0x2200, %%sr" ::: "memory");
}
#define BITMAP_X_ADD 0x4000
void set_PB_xosera()
{
    
    //xport_outw(XR_PB_GFX_CTRL, 0x006F); //Enable PB as BITMAP
    xport_outw(XR_PB_DISP_ADDR, BITMAP_X_ADD); //Bitmap start add
    xport_outw(XR_PB_LINE_LEN, 80); //640/4/2 @ 8bpp
    //xport_outw(XR_PA_GFX_CTRL, 0x00FF); //Disable PA
    xport_outw(XR_PB_HV_FSCALE, 0x0000); //Disable Sclae
    asm_STI(); //Disable ints
    

    
    
    
}
void clear_PB_xosera()
{
    
    asm_CLI(); //Enable ints
    //xport_outw(XR_PB_GFX_CTRL, 0x00F0); //Disable PB
    xport_outw(XR_PA_LINE_LEN, 80);
    xport_outw(XR_PA_H_SCROLL, 0);
    xport_outw(XR_PA_HV_FSCALE, 0);
    xport_outw(XR_PA_V_SCROLL, 0);
    xport_outw(XR_PA_TILE_CTRL, 0x400F);

    xport_outw(XR_PA_DISP_ADDR, 0x1000); //Reset to default
    xport_outw(XR_PA_GFX_CTRL, 0x0000); //Return PA GFX
    
    //Clear pallette
    x_outw(XM_WR_XADD, 0x8100); //PB color pallette
    
    for(int i = 0; i < 256; i++)
    {
        x_outw(XM_XDATA, 0x00FF);
    }

    //Clear PA screen
    
    printf("\n");
    
}
//Double X bc idc - 80x120
void plot_xy(int x, int y, uint32_t color)
{
    uint32_t add = BITMAP_X_ADD; //0,0
    add += x+y*120;
    x_outw(XM_WR_ADDR, add);
    x_outw(XM_DATA, color|color<<8);
}
//Load bitmap and 8bpp pallette in PB
int load_image(char *image, char *pallette, uint16_t wadd)
{
    FILE *fil = fopen(image, "rb"); //Image 8bpp, 160x120
    if (fil == NULL) {
        clear_PB_xosera(); //Reset to valid display
        perror("Error opening file");
        
        return -1;
    }
    uint16_t *wbuf = malloc(80*120*2);
    if(wbuf == NULL)
    {
        clear_PB_xosera(); //Reset to valid display
        perror("Malloc");
        
        return -1;
    }
    long read = fread(wbuf, 1, 80*120*2, fil);
    if(read != 80*120*2)
    {
        clear_PB_xosera(); //Reset to valid display
        perror("Error image size");
        
        return -1;
    }
    x_outw(XM_WR_ADDR, wadd);
    for(int i = 0; i < 80*120; i++)
    {
        *(uint16_t*)(XOSERA_BASE + XM_DATA) = wbuf[i];
        *(uint16_t*)(XOSERA_BASE + XM_DATA + 2) = wbuf[i] << 8;
    }
    fclose(fil);
    free(wbuf);
    //Done with image now for the pallette!

    fil = fopen(pallette, "rb"); //Pallette 0xARGB
    if (fil == NULL) {
        clear_PB_xosera(); //Reset to valid display
        perror("Error opening file");
        
        return -1;
    }
    wbuf = malloc(512);
    if(wbuf == NULL)
    {
        clear_PB_xosera(); //Reset to valid display
        perror("Malloc");
        
        return -1;
    }
    read = fread(wbuf, 1, 512, fil);
    if(read != 512)
    {
        clear_PB_xosera(); //Reset to valid display
        perror("Error pallette size");
        
        return -1;
    }
    x_outw(XM_WR_XADD, 0x8100); //PB color pallette
    
    for(int i = 0; i < 256; i++)
    {
        x_outw(XM_XDATA, wbuf[i]);
    }

    fclose(fil);
    free(wbuf);
    return 0;
}
int load_image_name(char* name)
{
    char nimg[256];
    char pnam[256];
    strcpy(nimg, name);
    strcpy(pnam, name);
    strcat(nimg, ".bit");
    strcat(pnam, ".pal");
    if(load_image(nimg, pnam, BITMAP_X_ADD))
    {
        clear_PB_xosera();
        return -1;
    }
    return 0;
}
#define PA_DISP_ADD 0x9000
void load_ascii(char* name)
{
    FILE *fil = fopen(name, "r");
    uint16_t *wbuf = malloc(80*32*2);
    uint16_t *wbuf2 = malloc(80*32*2);
    fread(wbuf, 1, 80*32*2, fil);
    x_outw(XM_WR_ADDR, PA_DISP_ADD);
    for(int i = 0; i < 80*32; i ++)
    {
        //x_outw(XM_DATA, wbuf[i]);
        
        *(uint16_t*)(XOSERA_BASE + XM_DATA) = wbuf[i];
        *(uint16_t*)(XOSERA_BASE + XM_DATA + 2) = wbuf[i] << 8;
        //wbuf2[i] = wbuf[i];
    }
    fclose(fil);
    free(wbuf);
    free(wbuf2);
}
void dma_test()
{
    volatile uint8_t source[TRANSFER_SIZE];
    volatile uint8_t destination[TRANSFER_SIZE];
    
    // Fill source with test data
    for (int i = 0; i < TRANSFER_SIZE; i++) {
        source[i] = (uint8_t)i;
        destination[i] = 0;
    }
    
    // Enable DMA Controller
    DMA_BASE[DMAC_CMD_REG] = DMAC_CMD_ENABLE;
    
    // Setup channel 0 registers
    volatile uint16_t *chan_base = &DMA_BASE[DMAC_CHAN_BASE];
    
    chan_base[CHAN_SRC_ADDR_HIGH] = ADDR_HIGH(source);
    chan_base[CHAN_SRC_ADDR_LOW]  = ADDR_LOW(source);
    
    chan_base[CHAN_DST_ADDR_HIGH] = ADDR_HIGH(destination);
    chan_base[CHAN_DST_ADDR_LOW]  = ADDR_LOW(destination);
    
    chan_base[CHAN_LCNT_HIGH] = 0;           // For 256 bytes, high count is 0
    chan_base[CHAN_LCNT_LOW]  = TRANSFER_SIZE;
    
    chan_base[CHAN_CONTROL] = CHAN_CTRL_MEM_TO_MEM | CHAN_CTRL_ENABLE;
    
    // Start channel 0 DMA transfer
    DMA_BASE[DMAC_CMD_REG] |= DMAC_CMD_START_CHAN0;
    
    // Wait for DMA transfer to complete (poll status)
    int to = 0;
    while ((DMA_BASE[DMAC_STATUS_REG] & 0x01) == 0) {
        delay(1); // Simple polling delay
        //printf("Wait\n");
        
        to++;
        if(to > 10000)
        {
            printf("Timeout Status: %x\n",DMA_BASE[DMAC_STATUS_REG]);
            break;
        }
    }
}
int main(int argc, char *argv[], char *envp[]) {
    printf("Start\n");
    dma_test();
    printf("Done\n");

    //clear_PB_xosera();
    return 0;
}