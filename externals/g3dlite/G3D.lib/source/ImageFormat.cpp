/**
 @file ImageFormat.cpp
 
 @maintainer Morgan McGuire, morgan@graphics3d.com
 
 @created 2003-05-23
 @edited  2006-01-11
 */

#include "../../GLG3D.lib/include/GLG3D/glheaders.h"
#include "../../GLG3D.lib/include/GLG3D/glcalls.h"
#include "G3D/ImageFormat.h"

namespace G3D {

ImageFormat::ImageFormat(
    int             _numComponents,
    bool            _compressed,
    int             _glFormat,
    int             _glBaseFormat,
    int             _luminanceBits,
    int             _alphaBits,
    int             _redBits,
    int             _greenBits,
    int             _blueBits,
    int             _depthBits,
    int             _stencilBits,
    int             _hardwareBitsPerTexel,
    int             _packedBitsPerTexel,
    int             glDataFormat,
    bool            _opaque,
    bool            _floatingPoint,
    Code            _code,
    ColorSpace      _colorSpace,
    BayerPattern    _bayerPattern) : 

    numComponents(_numComponents),
    compressed(_compressed),
    code(_code),
    colorSpace(_colorSpace),
    bayerPattern(_bayerPattern),
    openGLFormat(_glFormat),
    openGLBaseFormat(_glBaseFormat),
    luminanceBits(_luminanceBits),
    alphaBits(_alphaBits),
    redBits(_redBits),
    greenBits(_greenBits),
    blueBits(_blueBits),
    stencilBits(_stencilBits),
    depthBits(_depthBits),
    cpuBitsPerPixel(_packedBitsPerTexel),
    packedBitsPerTexel(_packedBitsPerTexel),
    openGLBitsPerPixel(_hardwareBitsPerTexel),
    hardwareBitsPerTexel(_hardwareBitsPerTexel),
    openGLDataFormat(glDataFormat),
    opaque(_opaque),
    floatingPoint(_floatingPoint) {

	debugAssert(_packedBitsPerTexel <= _hardwareBitsPerTexel);
}

const ImageFormat* ImageFormat::depth(int depthBits) {

    switch (depthBits) {
    case 16:
        return DEPTH16();

    case 24:
        return DEPTH24();

    case 32:
        return DEPTH32();

    default:
        debugAssertM(false, "Depth must be 16, 24, or 32.");
        return DEPTH32();
    }
}


const ImageFormat* ImageFormat::stencil(int bits) {
    switch (bits) {
    case 1:
        return STENCIL1();

    case 4:
        return STENCIL4();

    case 8:
        return STENCIL8();

    case 16:
        return STENCIL16();

    default:
        debugAssertM(false, "Stencil must be 1, 4, 8 or 16.");
        return STENCIL16();
    }
}


std::string ImageFormat::name() const {
    
    static const std::string nameArray[] = 
    {
        "L8", 
        "L16",
        "L16F",
        "L32F",

        "A8",
        "A16",
        "A16F",
        "A32F",

        "LA4",
        "LA8",
        "LA16",
        "LA16F",
        "LA32F",

        "RGB5",
        "RGB5A1",
        "RGB8",
        "RGB10",
        "RGB10A2",
        "RGB16",
        "RGB16F",
        "RGB32F",

        "ARGB8",
        "BGR8",

        "RGBA8",
        "RGBA16",
        "RGBA16F",
        "RGBA32F",

        "BAYER_RGGB8",
        "BAYER_GRBG8",
        "BAYER_GBRG8",
        "BAYER_BGGR8",
        "BAYER_RGGB32F",
        "BAYER_GRBG32F",
        "BAYER_GBRG32F",
        "BAYER_BGGR32F",

        "HSV8",
        "HSV32F",

        "YUV420_PLANAR",
        "YUV422",
        "YUV444",

        "RGB_DXT1",
        "RGBA_DXT1",
        "RGBA_DXT3",
        "RGBA_DXT5",

        "DEPTH16",
        "DEPTH24",
        "DEPTH32",
        "DEPTH32F",
        
        "STENCIL1",
        "STENCIL4",
        "STENCIL8",
        "STENCIL16",

        "DEPTH24_STENCIL8"
    };

    debugAssert(code < CODE_NUM);
    return nameArray[code];
}


const ImageFormat* ImageFormat::fromCode(ImageFormat::Code code) {
    switch (code) {
    case ImageFormat::CODE_L8:
        return ImageFormat::L8();
        break;
    case ImageFormat::CODE_L16:
        return ImageFormat::L16();
        break;
    case ImageFormat::CODE_L16F:
        return ImageFormat::L16F();
        break;
    case ImageFormat::CODE_L32F:
        return ImageFormat::L32F();
        break;

    case ImageFormat::CODE_A8:
        return ImageFormat::A8();
        break;
    case ImageFormat::CODE_A16:
        return ImageFormat::A16();
        break;
    case ImageFormat::CODE_A16F:
        return ImageFormat::A16F();
        break;
    case ImageFormat::CODE_A32F:
        return ImageFormat::A32F();
        break;

    case ImageFormat::CODE_LA4:
        return ImageFormat::LA4();
        break;
    case ImageFormat::CODE_LA8:
        return ImageFormat::LA8();
        break;
    case ImageFormat::CODE_LA16:
        return ImageFormat::LA16();
        break;
    case ImageFormat::CODE_LA16F:
        return ImageFormat::LA16F();
        break;
    case ImageFormat::CODE_LA32F:
        return ImageFormat::LA32F();
        break;

    case ImageFormat::CODE_RGB5:
        return ImageFormat::RGB5();
        break;
    case ImageFormat::CODE_RGB5A1:
        return ImageFormat::RGB5A1();
        break;
    case ImageFormat::CODE_RGB8:
        return ImageFormat::RGB8();
        break;
    case ImageFormat::CODE_RGB10:
        return ImageFormat::RGB10();
        break;
    case ImageFormat::CODE_RGB10A2:
        return ImageFormat::RGB10A2();
        break;
    case ImageFormat::CODE_RGB16:
        return ImageFormat::RGB16();
        break;
    case ImageFormat::CODE_RGB16F:
        return ImageFormat::RGB16F();
        break;
    case ImageFormat::CODE_RGB32F:
        return ImageFormat::RGB32F();
        break;

    case ImageFormat::CODE_ARGB8:
        return NULL;

    case ImageFormat::CODE_BGR8:
        return NULL;

    case ImageFormat::CODE_RGBA8:
        return ImageFormat::RGBA8();
        break;
    case ImageFormat::CODE_RGBA16:
        return ImageFormat::RGBA16();
        break;
    case ImageFormat::CODE_RGBA16F:
        return ImageFormat::RGBA16F();
        break;
    case ImageFormat::CODE_RGBA32F:
        return ImageFormat::RGBA32F();
        break;

    case ImageFormat::CODE_BAYER_RGGB8:
    case ImageFormat::CODE_BAYER_GRBG8:
    case ImageFormat::CODE_BAYER_GBRG8:
    case ImageFormat::CODE_BAYER_BGGR8:
    case ImageFormat::CODE_BAYER_RGGB32F:
    case ImageFormat::CODE_BAYER_GRBG32F:
    case ImageFormat::CODE_BAYER_GBRG32F:
    case ImageFormat::CODE_BAYER_BGGR32F:

    case ImageFormat::CODE_HSV8:
    case ImageFormat::CODE_HSV32F:

    case ImageFormat::CODE_RGB_DXT1:
        return ImageFormat::RGB_DXT1();
        break;
    case ImageFormat::CODE_RGBA_DXT1:
        return ImageFormat::RGBA_DXT1();
        break;
    case ImageFormat::CODE_RGBA_DXT3:
        return ImageFormat::RGBA_DXT3();
        break;
    case ImageFormat::CODE_RGBA_DXT5:
        return ImageFormat::RGBA_DXT5();
        break;

    case ImageFormat::CODE_DEPTH16:
        return ImageFormat::DEPTH16();
        break;
    case ImageFormat::CODE_DEPTH24:
        return ImageFormat::DEPTH24();
        break;
    case ImageFormat::CODE_DEPTH32:
        return ImageFormat::DEPTH32();
        break;
    case ImageFormat::CODE_DEPTH32F:
        return ImageFormat::DEPTH32F();
        break;

    case ImageFormat::CODE_STENCIL1:
        return ImageFormat::STENCIL1();
        break;
    case ImageFormat::CODE_STENCIL4:
        return ImageFormat::STENCIL4();
        break;
    case ImageFormat::CODE_STENCIL8:
        return ImageFormat::STENCIL8();
        break;
    case ImageFormat::CODE_STENCIL16:
        return ImageFormat::STENCIL16();
        break;

    case ImageFormat::CODE_DEPTH24_STENCIL8:
        return ImageFormat::DEPTH24_STENCIL8();
        break;

    case ImageFormat::CODE_YUV420_PLANAR:
        return ImageFormat::YUV420_PLANAR();
        break;

    case ImageFormat::CODE_YUV422:
        return ImageFormat::YUV422();
        break;

    case ImageFormat::CODE_YUV444:
        return ImageFormat::YUV444();
        break;

    default:
        return NULL;
    }
}

// Helper variables for defining texture formats

// Is floating point format
static const bool FLOAT_FORMAT  = true;
static const bool INT_FORMAT    = false;

// Is opaque format (no alpha)
static const bool OPAQUE_FORMAT = true;
static const bool CLEAR_FORMAT  = false;

// Is compressed format (not raw component data)
static const bool COMP_FORMAT   = true;
static const bool UNCOMP_FORMAT = false;

#define DEFINE_TEXTUREFORMAT_METHOD(name, cmpnts, cmprssd, glf, glbf, lb, rb, gb, bb, db, sb, hbpt, pbpt, gldf, opq, fp, code, cs, bp)                    \
    const ImageFormat* ImageFormat::name() {                                                                                                  \
    static const ImageFormat format(cmpnts, cmprssd, glf, glbf, lb, rb, gb, bb, db, sb, hbpt, pbpt, gldf, opq, fp, code, cs, bp);  \
    return &format; }

DEFINE_TEXTUREFORMAT_METHOD(L8,         1, UNCOMP_FORMAT,   GL_LUMINANCE8,      GL_LUMINANCE,   8, 0, 0, 0, 0, 0, 0, 8, 8,  GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, CODE_L8, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(L16,        1, UNCOMP_FORMAT,   GL_LUMINANCE16,     GL_LUMINANCE,  16, 0, 0, 0, 0, 0, 0, 16, 16,GL_UNSIGNED_SHORT, OPAQUE_FORMAT, INT_FORMAT, CODE_L16, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(L16F,       1, UNCOMP_FORMAT,   GL_LUMINANCE16F_ARB,GL_LUMINANCE, 16, 0, 0, 0, 0, 0, 0, 16, 16, GL_FLOAT, OPAQUE_FORMAT, FLOAT_FORMAT, CODE_L16F, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(L32F,       1, UNCOMP_FORMAT,   GL_LUMINANCE32F_ARB,GL_LUMINANCE, 32, 0, 0, 0, 0, 0, 0, 32, 32, GL_FLOAT, OPAQUE_FORMAT, FLOAT_FORMAT, CODE_L32F, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(A8,         1, UNCOMP_FORMAT,   GL_ALPHA8,          GL_ALPHA,   0, 8, 0, 0, 0, 0, 0, 8, 8,      GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, CODE_A8, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(A16,        1, UNCOMP_FORMAT,   GL_ALPHA16,         GL_ALPHA,   0, 16, 0, 0, 0, 0, 0, 16, 16,   GL_UNSIGNED_SHORT, CLEAR_FORMAT, INT_FORMAT, CODE_A16, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(A16F,       1, UNCOMP_FORMAT,   GL_ALPHA16F_ARB,    GL_ALPHA,   0, 16, 0, 0, 0, 0, 0, 16, 16,   GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, CODE_A16F, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(A32F,       1, UNCOMP_FORMAT,   GL_ALPHA32F_ARB,    GL_ALPHA,   0, 32, 0, 0, 0, 0, 0, 32, 32,   GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, CODE_A32F, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(LA4,        2, UNCOMP_FORMAT,   GL_LUMINANCE4_ALPHA4,       GL_LUMINANCE_ALPHA, 4, 4, 0, 0, 0, 0, 0, 8, 8,              GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, CODE_LA4, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(LA8,        2, UNCOMP_FORMAT,   GL_LUMINANCE8_ALPHA8,       GL_LUMINANCE_ALPHA, 8, 8, 0, 0, 0, 0, 0, 16, 16,            GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, CODE_LA8, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(LA16,       2, UNCOMP_FORMAT,   GL_LUMINANCE16_ALPHA16,     GL_LUMINANCE_ALPHA, 16, 16, 0, 0, 0, 0, 0, 16*2, 16*2,      GL_UNSIGNED_SHORT, CLEAR_FORMAT, INT_FORMAT, CODE_LA16, COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(LA16F,      2, UNCOMP_FORMAT,   GL_LUMINANCE_ALPHA16F_ARB,  GL_LUMINANCE_ALPHA, 16, 16, 0, 0, 0, 0, 0, 16*2, 16*2,      GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_LA16F, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(LA32F,      2, UNCOMP_FORMAT,   GL_LUMINANCE_ALPHA32F_ARB,  GL_LUMINANCE_ALPHA, 32, 32,  0,  0,  0,  0,  0, 32*2, 32*2, GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_LA32F, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(BGR8,       3, UNCOMP_FORMAT,   GL_RGB8,            GL_BGR,     0,  0,  8,  8,  8,  0,  0, 32, 24,      GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_BGR8, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB5,       3, UNCOMP_FORMAT,   GL_RGB5,            GL_RGBA,    0,  0,  5,  5,  5,  0,  0, 16, 16,      GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB5, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB5A1,     4, UNCOMP_FORMAT,   GL_RGB5_A1,         GL_RGBA,    0,  1,  5,  5,  5,  0,  0, 16, 16,      GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB5A1, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB8,       3, UNCOMP_FORMAT,   GL_RGB8,            GL_RGB,     0,  0,  8,  8,  8,  0,  0, 32, 24,      GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB8, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB10,      3, UNCOMP_FORMAT,   GL_RGB10,                           GL_RGB,     0,  0, 10, 10, 10,  0,  0, 32, 10*3,    GL_UNSIGNED_SHORT, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB10, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB10A2,    4, UNCOMP_FORMAT,   GL_RGB10_A2,                        GL_RGBA,    0,  2, 10, 10, 10,  0,  0, 32, 32,      GL_UNSIGNED_INT_10_10_10_2, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB10A2, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB16,      3, UNCOMP_FORMAT,   GL_RGB16,                           GL_RGB,     0,  0, 16, 16, 16,  0,  0, 16*3, 16*3,  GL_UNSIGNED_SHORT, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB16, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB16F,     3, UNCOMP_FORMAT,   GL_RGB16F_ARB,                      GL_RGB,     0,  0, 16, 16, 16,  0,  0, 16*3, 16*3,  GL_FLOAT, OPAQUE_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_RGB16F, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB32F,     3, UNCOMP_FORMAT,   GL_RGB32F_ARB,                      GL_RGB,     0,  0, 32, 32, 32,  0,  0, 32*3, 32*3,  GL_FLOAT, OPAQUE_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_RGB32F, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA8,      4, UNCOMP_FORMAT,   GL_RGBA8,                           GL_RGBA,    0,  8,  8,  8,  8,  0,  0, 32, 32,      GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_RGBA8, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA16,     4, UNCOMP_FORMAT,   GL_RGBA16,                          GL_RGBA,    0, 16, 16, 16, 16, 0, 0, 16*4, 16*4,    GL_UNSIGNED_SHORT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_RGBA16, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA16F,    4, UNCOMP_FORMAT,   GL_RGBA16F_ARB,                     GL_RGBA,    0, 16, 16, 16, 16, 0, 0, 16*4, 16*4,    GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_RGB16F, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA32F,    4, UNCOMP_FORMAT,   GL_RGBA32F_ARB,                     GL_RGBA,    0, 32, 32, 32, 32, 0, 0, 32*4, 32*4,    GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_RGBA32F, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGB_DXT1,   3, COMP_FORMAT,     GL_COMPRESSED_RGB_S3TC_DXT1_EXT,    GL_RGB,     0, 0, 0, 0, 0, 0, 0, 64, 64,    GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_RGB_DXT1, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA_DXT1,  4, COMP_FORMAT,     GL_COMPRESSED_RGBA_S3TC_DXT1_EXT,   GL_RGBA,    0, 0, 0, 0, 0, 0, 0, 64, 64,    GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_RGBA_DXT1, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA_DXT3,  4, COMP_FORMAT,     GL_COMPRESSED_RGBA_S3TC_DXT3_EXT,   GL_RGBA,    0, 0, 0, 0, 0, 0, 0, 128, 128,  GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_RGBA_DXT3, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(RGBA_DXT5,  4, COMP_FORMAT,     GL_COMPRESSED_RGBA_S3TC_DXT5_EXT,   GL_RGBA,    0, 0, 0, 0, 0, 0, 0, 128, 128,  GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_RGBA_DXT5, ImageFormat::COLOR_SPACE_RGB);

DEFINE_TEXTUREFORMAT_METHOD(DEPTH16,    1, UNCOMP_FORMAT,   GL_DEPTH_COMPONENT16_ARB,           GL_DEPTH_COMPONENT, 0, 0, 0, 0, 0, 0, 16, 16, 16,   GL_UNSIGNED_SHORT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_DEPTH16, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(DEPTH24,    1, UNCOMP_FORMAT,   GL_DEPTH_COMPONENT24_ARB,           GL_DEPTH_COMPONENT, 0, 0, 0, 0, 0, 0, 24, 32, 24,   GL_UNSIGNED_INT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_DEPTH24, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(DEPTH32,    1, UNCOMP_FORMAT,   GL_DEPTH_COMPONENT32_ARB,           GL_DEPTH_COMPONENT, 0, 0, 0, 0, 0, 0, 32, 32, 32,   GL_UNSIGNED_INT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_DEPTH32, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(DEPTH32F,   1, UNCOMP_FORMAT,   GL_DEPTH_COMPONENT32_ARB,           GL_DEPTH_COMPONENT, 0, 0, 0, 0, 0, 0, 32, 32, 32,   GL_FLOAT, CLEAR_FORMAT, FLOAT_FORMAT, ImageFormat::CODE_DEPTH32F, ImageFormat::COLOR_SPACE_NONE);

// These formats are for use with Renderbuffers only!
DEFINE_TEXTUREFORMAT_METHOD(STENCIL1,   1, UNCOMP_FORMAT,   GL_STENCIL_INDEX1_EXT,              GL_STENCIL_INDEX_EXT,  0, 0, 0, 0, 0, 0, 1, 1, 1,      GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_STENCIL1, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(STENCIL4,   1, UNCOMP_FORMAT,   GL_STENCIL_INDEX4_EXT,              GL_STENCIL_INDEX_EXT,  0, 0, 0, 0, 0, 0, 4, 4, 4,      GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_STENCIL4, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(STENCIL8,   1, UNCOMP_FORMAT,   GL_STENCIL_INDEX8_EXT,              GL_STENCIL_INDEX_EXT,  0, 0, 0, 0, 0, 0, 8, 8, 8,      GL_UNSIGNED_BYTE, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_STENCIL8, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(STENCIL16,  1, UNCOMP_FORMAT,   GL_STENCIL_INDEX16_EXT,             GL_STENCIL_INDEX_EXT, 0, 0, 0, 0, 0, 0, 16, 16, 16,   GL_UNSIGNED_SHORT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_STENCIL16, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(DEPTH24_STENCIL8,   2, UNCOMP_FORMAT,   GL_DEPTH24_STENCIL8_EXT,    GL_DEPTH_STENCIL_EXT,0, 0, 0, 0, 0, 24, 8, 32, 32,  GL_UNSIGNED_INT, CLEAR_FORMAT, INT_FORMAT, ImageFormat::CODE_DEPTH24_STENCIL8, ImageFormat::COLOR_SPACE_NONE);

DEFINE_TEXTUREFORMAT_METHOD(YUV420_PLANAR,  3, UNCOMP_FORMAT,   GL_NONE,    GL_NONE, 0, 0, 0, 0, 0, 0, 0, 12, 12,  GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_YUV420_PLANAR, ImageFormat::COLOR_SPACE_YUV);
DEFINE_TEXTUREFORMAT_METHOD(YUV422,         3, UNCOMP_FORMAT,   GL_NONE,    GL_NONE, 0, 0, 0, 0, 0, 0, 0, 16, 16,  GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_YUV422, ImageFormat::COLOR_SPACE_YUV);
DEFINE_TEXTUREFORMAT_METHOD(YUV444,         3, UNCOMP_FORMAT,   GL_NONE,    GL_NONE, 0, 0, 0, 0, 0, 0, 0, 24, 24,  GL_UNSIGNED_BYTE, OPAQUE_FORMAT, INT_FORMAT, ImageFormat::CODE_YUV444, ImageFormat::COLOR_SPACE_YUV);

}
