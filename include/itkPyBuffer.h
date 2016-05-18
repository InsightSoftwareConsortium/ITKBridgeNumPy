/*=========================================================================
 *
 *  Copyright Insight Software Consortium
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0.txt
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *=========================================================================*/

#ifndef itkPyBuffer_h
#define itkPyBuffer_h

#include "itkObject.h"
#include "itkObjectFactory.h"
#include "itkImportImageFilter.h"
#include "itkDefaultConvertPixelTraits.h"


// The python header defines _POSIX_C_SOURCE without a preceding #undef
#undef _POSIX_C_SOURCE
#include <Python.h>

namespace itk
{

/** \class PyBuffer
 *
 *  \brief Helper class for converting C buffers into python arrays.
 *
 *  This class will receive a C buffer and create the equivalent python
 *  array. This permits passing image buffers into python arrays from
 *  the NumPy python package.
 *
 *  \ingroup BridgeNumPy
 */
template <typename TImage>
class PyBuffer
{
public:
  /** Standard "Self" typedef. */
  typedef PyBuffer         Self;

  /** Type of the image from which the buffer will be converted */
  typedef TImage                                                       ImageType;
  typedef typename ImageType::PixelType                                PixelType;
  typedef typename ImageType::SizeType                                 SizeType;
  typedef typename ImageType::IndexType                                IndexType;
  typedef typename ImageType::RegionType                               RegionType;
  typedef typename ImageType::PointType                                PointType;
  typedef typename ImageType::SpacingType                              SpacingType;
  typedef typename ImageType::Pointer                                  ImagePointer;
  typedef typename DefaultConvertPixelTraits<PixelType>::ComponentType ComponentType;

   /** Image dimension. */
  itkStaticConstMacro(ImageDimension, unsigned int, ImageType::ImageDimension);

  typedef typename Image< ComponentType, ImageDimension >::Pointer  OutputImagePointer;

  /**
   * Get an Array with the content of the image buffer
   */
  static PyObject * _GetArrayFromImage( ImageType * image, bool keepAxes = false);

  /**
   * Get an ITK image from a Python array
   */
  static const OutputImagePointer _GetImageFromArray( PyObject *arr, PyObject *shape, PyObject *numOfComponent);

protected:

private:
  PyBuffer(const Self&);       // Purposely not implemented.
  void operator=(const Self&); // Purposely not implemented.
};

} // namespace itk

#ifndef ITK_MANUAL_INSTANTIATION
#include "itkPyBuffer.hxx"
#endif

#endif // _itkPyBuffer_h
