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
#ifndef __itkPyBuffer_hxx
#define __itkPyBuffer_hxx

#include "itkPyBuffer.h"

// Deal with slight incompatibilites between NumPy (the future, hopefully),
// Numeric (old version) and Numarray's Numeric compatibility module (also old).
#ifndef NDARRAY_VERSION
// NDARRAY_VERSION is only defined by NumPy's arrayobject.h
// In non NumPy arrayobject.h files, PyArray_SBYTE is used instead of BYTE.
#define PyArray_BYTE PyArray_SBYTE
#endif

namespace itk
{

template<class TImage>
PyObject *
PyBuffer<TImage>
::GetArrayFromImage( ImageType * image )
{
  if( !image )
  {
    throw std::runtime_error("Input image is null");
  }

  image->Update();

  ComponentType * buffer = const_cast < ComponentType * > ( image->GetBufferPointer() );
  char * data = (char *)( buffer );
 
  IndexType index;
  index.Fill(0);
  int nrOfComponents = DefaultConvertPixelTraits<PixelType>::GetNumberOfComponents(image->GetPixel(index));

  int item_type = PyTypeTraits<ComponentType>::value;

  int dimensions[ ImageDimension + 1 ];
  dimensions[ImageDimension] = nrOfComponents;

  // Invert order of Dimensions
  SizeType size = image->GetBufferedRegion().GetSize();
  for(unsigned int d=0; d < ImageDimension; d++ )
  {
    dimensions[ImageDimension - d-1] = size[d];
  }

  PyObject * obj;
  if ( nrOfComponents > 1)
  {
    // Create a N+1 dimensional PyArray
    obj = PyArray_FromDimsAndData( ImageDimension + 1, dimensions, item_type, data );
  }
  else
  {
   // Create a N dimensional PyArray
    obj = PyArray_FromDimsAndData( ImageDimension, dimensions + 1, item_type, data );
  }

  return obj;
}

template<class TImage>
const typename PyBuffer<TImage>::OutImagePointer
PyBuffer<TImage>
::GetImageFromArray( PyObject *obj )
{

    int element_type = PyTypeTraits<ComponentType>::value;

    PyArrayObject * parray =
          (PyArrayObject *) PyArray_ContiguousFromObject(
                                                    obj,
                                                    element_type,
                                                    ImageDimension,
                                                    ImageDimension  );

    if( parray == NULL )
      {
      throw std::runtime_error("Contiguous array couldn't be created from input python object");
      }

    const unsigned int imageDimension = parray->nd;

    SizeType size;

    unsigned int numberOfPixels = 1;

    for( unsigned int d=0; d<imageDimension; d++ )
      {
      size[imageDimension - d - 1]         = parray->dimensions[d];
      numberOfPixels *= parray->dimensions[d];
      }

    IndexType start;
    start.Fill( 0 );

    RegionType region;
    region.SetIndex( start );
    region.SetSize( size );

    PointType origin;
    origin.Fill( 0.0 );

    SpacingType spacing;
    spacing.Fill( 1.0 );

    ImporterPointer importer = ImporterType::New();
    importer->SetRegion( region );
    importer->SetOrigin( origin );
    importer->SetSpacing( spacing );

    const bool importImageFilterWillOwnTheBuffer = false;

    ComponentType * data = (ComponentType *)parray->data;

    importer->SetImportPointer(
                        data,
                        numberOfPixels,
                        importImageFilterWillOwnTheBuffer );

    importer->Update();
    OutImagePointer output = importer->GetOutput();
    output->DisconnectPipeline();

    return output;
}


} // namespace itk

#endif
