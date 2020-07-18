#ifndef _ROCm_H
#define _ROCm_H

#include "ppcg_options.h"
#include "ppcg.h"

int generate_rocm(isl_ctx *ctx, struct ppcg_options *options,
	const char *input);
#endif
