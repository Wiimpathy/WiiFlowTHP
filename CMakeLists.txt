cmake_minimum_required(VERSION 3.10)
project(avthp)
add_subdirectory(libjpeg-turbo)
find_path(INCLUDE_PATH libavcodec/avcodec.h)
include_directories(${INCLUDE_PATH})
add_executable(avthp dsp.c encodeaudio.c main.c)

find_library(AVCODEC_LIBRARY avcodec)
find_library(AVFORMAT_LIBRARY avformat)
find_library(AVUTIL_LIBRARY avutil)
find_library(SWSCALE_LIBRARY swscale)
find_library(SWRESAMPLE_LIBRARY swresample)
if(CMAKE_CROSSCOMPILING)
find_library(VORBIS_LIBRARY vorbis)
find_library(VORBISFILE_LIBRARY vorbisfile)
find_library(VORBISENC_LIBRARY vorbisenc)
find_library(OGG_LIBRARY ogg)
find_library(BCRYPT_LIBRARY bcrypt)
# Not found with wine!
#find_library(PTHREAD_LIBRARY pthread)
#find_library(PTHREAD_LIBRARY winpthread)
find_library(LM_LIBRARY m)
find_library(ZLIB_LIBRARY z)
find_library(MFP_LIBRARY mfplat)
find_library(MFU_LIBRARY mfuuid)
find_library(STRMIIDS_LIBRARY strmiids)
find_library(MP3_LIBRARY mp3lame)
find_library(X264_LIBRARY x264)
endif()

if(NOT WIN32)
  find_library(M_LIBRARY m)
endif()

if(CMAKE_CROSSCOMPILING)
target_link_libraries(avthp libjpeg-turbo
                      ${AVFORMAT_LIBRARY}
                      ${AVCODEC_LIBRARY}
                      ${AVUTIL_LIBRARY}
                      ${SWSCALE_LIBRARY}
                      ${SWRESAMPLE_LIBRARY}
                      ${ZLIB_LIBRARY}
                      ${VORBIS_LIBRARY}
                      ${OGG_LIBRARY}
                      ${VORBISFILE_LIBRARY}
                      ${VORBISENC_LIBRARY}
                      ${MFP_LIBRARY_LIBRARY}
                      ${MFU_LIBRARY_LIBRARY}
                      ${STRMIIDS_LIBRARY}
                      ${OLE32_LIBRARY}
                      ${BCRYPT_LIBRARY}
                      ${M_LIBRARY}
                      ${X264_LIBRARY}
                      ${MP3_LIBRARY}
                      ${MFP_LIBRARY}
                      ${MFU_LIBRARY}
                       -static -lpthread)
else()
target_link_libraries(avthp libjpeg-turbo
                      ${AVFORMAT_LIBRARY}
                      ${AVCODEC_LIBRARY}
                      ${SWSCALE_LIBRARY}
                      ${SWRESAMPLE_LIBRARY}
                      ${AVUTIL_LIBRARY}
                      ${M_LIBRARY})
endif()

if(CMAKE_CROSSCOMPILING)
SET(EXTENSION .exe)
endif()

add_custom_command(TARGET avthp POST_BUILD
            COMMAND ${CMAKE_STRIP} avthp${EXTENSION})
