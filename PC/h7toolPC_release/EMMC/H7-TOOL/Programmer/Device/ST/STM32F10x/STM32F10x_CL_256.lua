-------------------------------------------------------
-- 文件名 : STM32F10x_CL_256.lua
-- 版  本 : V1.0  2020-04-28
-- 说  明 :
-------------------------------------------------------

print("load \"STM32F10x_CL_256.lua\" ok")

IncludeList = {
	"0:/H7-TOOL/Programmer/Device/ST/Lib/STM32F1_Lib_E0042000.lua"
}

function config_cpu(void)
	CHIP_TYPE = "SWD"		--指定器件接口类型: "SWD", "SWIM", "SPI", "I2C", "UART"

	AlgoFile_FLASH = "0:/H7-TOOL/Programmer/Device/ST/STM32F10x/STM32F10x_CL.FLM"
	AlgoFile_OTP   = ""
	AlgoFile_OPT   = "0:/H7-TOOL/Programmer/Device/ST/STM32F10x/STM32F10x_OPT.FLM"
	AlgoFile_QSPI  = ""

	FLASH_ADDRESS = 0x08000000		--CPU内部FLASH起始地址
	FLASH_SIZE	= 256 * 1024		--覆盖FLM文件中的容量参数

	RAM_ADDRESS = 0x20000000		--CPU内部RAM起始地址

	--Flash算法文件加载内存地址和大小
	AlgoRamAddr = RAM_ADDRESS
	AlgoRamSize = 8 * 1024

	MCU_ID = 0x01BA01477

	UID_ADDR = 0x1FFFF7E8	   	--UID地址，不同的CPU不同
	UID_BYTES = 12

	--缺省校验模式
	VERIFY_MODE = 0				-- 0:读回校验, 1:软件CRC32校验, 其他:扩展硬件CRC(需要单片机支持）

	ERASE_CHIP_TIME = 500		--全片擦除时间ms（仅用于进度指示)

	--地址组中的FFFFFFFF表示原始数据中插入一个取反的字节
	OB_ADDRESS     = "1FFFF800 FFFFFFFF 1FFFF802 FFFFFFFF 1FFFF804 FFFFFFFF 1FFFF806 FFFFFFFF 1FFFF808 FFFFFFFF 1FFFF80A FFFFFFFF 1FFFF80C FFFFFFFF 1FFFF80E FFFFFFFF"

	OB_SECURE_OFF  = "A5 FF FF FF FF FF FF FF"	--SECURE_ENABLE = 0时，编程完毕后写入该值
	OB_SECURE_ON   = "00 FF FF FF FF FF FF FF"	--SECURE_ENABLE = 1时，编程完毕后写入该值

	--判断读保护和写保护的条件(WRP = Write protection)
	OB_WRP_ADDRESS   = {0x1FFFF800, 0x1FFFF808, 0x1FFFF80A, 0x1FFFF80C, 0x1FFFF80E} 	--内存地址
	OB_WRP_MASK  	 = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF}		--读出数据与此数相与
	OB_WRP_VALUE 	 = {0xA5, 0xFF, 0xFF, 0xFF, 0xFF}		--相与后与此数比较，相等表示没有保护
end

--用于PC软件, 设置缺省配置参数
function pc_default(void)
	TVCC_VOLT = 3.3			--定义CPU供电电压TVCC
	
	VERIFY_MODE = 0			--校验模式: 0:自动(FLM提供校验函数或读回) 1:读回  2:软件CRC32  3:STM32硬件CRC32

	REMOVE_RDP_POWEROFF = 1 --写完OB后需要断电
	POWEROFF_TIME1 = 0   	--写完OB延迟时间ms
	POWEROFF_TIME2 = 100   	--断电时间ms
	POWEROFF_TIME3 = 20   	--上电后等待时间ms

	SWD_CLOCK_DELAY_0 = 0 	--单路烧录时的时钟延迟
	SWD_CLOCK_DELAY_1 = 0 	--多路烧录时的时钟延迟
	
	AUTO_REMOVE_PROTECT = 1 --自动解除读保护

	NOTE_PC = ""	
end

---------------------------结束-----------------------------------
