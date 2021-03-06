 SOURCES := \
 	ics32.v \
 	picorv32.v \
 	cpu_ram.v \
 	vram.v \
 	address_decoder.v \
 	delay_ff.v \
 	flash_dma.v \
 	pll.v \
 	bus_arbiter.v \
 	reset_generator.v \
 	cpu_peripheral_sync.v \
 	cop_ram.v \
 	flash_reader.v

VDP_SOURCES := vdp/vdp.v \
	 $(addprefix vdp/vdp_, \
		scroll_pixel_generator.v \
		layer_priority_select.v \
		map_address_generator.v \
		tile_address_generator.v \
		host_interface.v \
		priority_compute.v \
		vga_timing.v \
		sprite_raster_collision.v \
	 	sprite_core.v \
	 	sprite_render.v \
	 	affine_layer.v \
	 	blender.v \
	 	copper.v \
		vram_bus_arbiter_interleaved.v \
		vram_bus_arbiter_standard.v \
	)

SOURCES := $(SOURCES) $(VDP_SOURCES)
