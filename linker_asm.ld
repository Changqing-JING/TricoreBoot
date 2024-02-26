SECTIONS
{
	. = 0x80000000,
	.text : { *(.text) }

	. = 0x11223344,
	.shared_data : { *(.shared_data) }

	
}