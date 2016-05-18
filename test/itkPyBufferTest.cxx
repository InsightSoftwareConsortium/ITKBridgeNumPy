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
#include "NumpyHelper.h"
#include "itkPyBuffer.h"

#include "itkImage.h"
#include "itkVectorImage.h"

int itkPyBufferTest(int, char * [])
{
  try
    {
    NumpyHelper::Initialize();

    const unsigned int Dimension = 3;
    typedef unsigned char                          PixelType;
    typedef itk::Image<PixelType, Dimension>       ScalarImageType;
    typedef itk::VectorImage<PixelType, Dimension> VectorImageType;
    typedef itk::ImageRegion<Dimension>            RegionType;

    RegionType region;
    region.SetSize(0,200);
    region.SetSize(1,100);
    region.SetSize(2,10);

    // Test for scalar image
    ScalarImageType::Pointer scalarImage = ScalarImageType::New();
    scalarImage->SetRegions(region);
    scalarImage->Allocate();

    PyObject* scalarPyBuffer = itk::PyBuffer<ScalarImageType>::_GetArrayFromImage(scalarImage);
    //itk::PyBuffer<ScalarImageType>::_GetImageFromArray(scalarPyBuffer);


    // Test for vector image
    VectorImageType::Pointer vectorImage = VectorImageType::New();
    vectorImage->SetRegions(region);
    vectorImage->SetNumberOfComponentsPerPixel(3);
    vectorImage->Allocate();

    PyObject* vectorPyBuffer = itk::PyBuffer<VectorImageType>::_GetArrayFromImage(vectorImage);
    // TODO: More work needs to be done in the conversion from ImageToArray
    (void) vectorPyBuffer;
    //itk::PyBuffer<VectorImageType>::GetImageFromArray(vectorPyBuffer);
    //itk::PyBuffer<ScalarImageType>::GetImageFromArray(vectorPyBuffer);
    }
  catch( itk::ExceptionObject & error )
    {
    std::cerr << "Error: " << error << std::endl;
    return EXIT_FAILURE;
    }
  catch( const std::exception & error )
    {
    std::cerr << "Error: " << error.what() << std::endl;
    return EXIT_FAILURE;
    }

  return EXIT_SUCCESS;

}
