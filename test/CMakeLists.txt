itk_module_test()

if(ITK_WRAP_PYTHON AND NOT "${ITK_VERSION_MAJOR}.${ITK_VERSION_MINOR}" VERSION_LESS 4.11)

  execute_process(COMMAND ${PYTHON_EXECUTABLE} -c "import numpy"
    RESULT_VARIABLE _have_numpy_return_code
    OUTPUT_QUIET
    ERROR_QUIET
    )
  if(_have_numpy_return_code EQUAL 0)
    itk_python_add_test(NAME itkPyBufferTest
                        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/itkPyBufferTest.py
    )
    itk_python_add_test(NAME itkPyVnlTest
                        COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/itkPyVnlTest.py
    )
  endif()

  itk_python_add_test(NAME itkPyBufferMemoryLeakTest
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/itkPyBufferMemoryLeakTest.py
  )
endif()
