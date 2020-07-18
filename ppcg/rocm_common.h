#ifndef _ROCm_COMMON_H_
#define _ROCm_COMMON_H_

#include <stdio.h>


struct rocm_info {
	FILE *host_c;
	FILE *kernel_c;
	FILE *kernel_h;
};

void rocm_open_files(struct rocm_info *info, const char *input);
void rocm_close_files(struct rocm_info *info);

#endif
