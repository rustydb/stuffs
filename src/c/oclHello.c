#include <stdio.h>
#include <stdlib.h>
#include <CL/opencl.h>

int main(int argc, char* argv[]) {
    int err;
    cl_uint platforms;
    cl_platform_id platform;
    char cBuffer[1024];
    err = clGetPlatformIDs(1, &platform, &platforms);
    if (err != CL_SUCCESS) {
        printf("Error in OpenCL call %d\n", err);
        return EXIT_FAILURE;
    }
    printf("Number of platforms: %d\n", platforms);
    err = clGetPlatformInfo(platform, CL_PLATFORM_NAME, sizeof(cBuffer), cBuffer, NULL);
    if (err != CL_SUCCESS) {
        printf("Error in OpenCL call!\n");
        return EXIT_FAILURE;
    }
    printf("C_PLATFORM_NAME :\t %s\n", cBuffer);
    err = clGetPlatformInfo(platform, CL_PLATFORM_VERSION, sizeof(cBuffer), cBuffer, NULL);
    if (err != CL_SUCCESS) {
        printf("Error in OpenCL call!!\n");
        return EXIT_FAILURE;
    }
    printf("CL_PLATFORM_VERSION :\t %s\n", cBuffer);
}
