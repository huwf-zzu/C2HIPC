/*
 * Copyright 2010      INRIA Saclay
 *
 * Use of this software is governed by the MIT license
 *
 * Written by Sven Verdoolaege, INRIA Saclay - Ile-de-France,
 * Parc Club Orsay Universite, ZAC des vignes, 4 rue Jacques Monod,
 * 91893 Orsay, France
 */

#include <ctype.h>
#include <limits.h>
#include <string.h>

#include "rocm_common.h"
#include "ppcg.h"


void rocm_open_files(struct rocm_info *info, const char *input)
{
    char name[PATH_MAX];
    int len;

    len = ppcg_extract_base_name(name, input);

    strcpy(name + len, "_host.hip.cpp");
    info->host_c = fopen(name, "w");

    strcpy(name + len, "_kernel.hip.cpp");
    info->kernel_c = fopen(name, "w");

    strcpy(name + len, "_kernel.hip.hpp");
    info->kernel_h = fopen(name, "w");
    fprintf(info->host_c, "#include <assert.h>\n");
    fprintf(info->host_c, "#include <stdio.h>\n");
    fprintf(info->host_c, "#include \"%s\"\n", name);
    fprintf(info->kernel_c, "#include \"%s\"\n", name);
    fprintf(info->kernel_h, "#include \"hip/hip_runtime.h\"\n\n");
}

/* Close all output files.
 *  */
void rocm_close_files(struct rocm_info *info)
{
    fclose(info->kernel_c);
    fclose(info->kernel_h);
    fclose(info->host_c);
}

