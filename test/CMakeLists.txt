#itk_module_test()

#set(BridgeNumPyTests
#  itkPyBufferTest.cxx
#  )

#set(BridgeNumPy-Test_LIBRARIES "${BridgeNumPy-Test_LIBRARIES};${PYTHON_LIBRARY}")

#CreateTestDriver(BridgeNumPy "${BridgeNumPy-Test_LIBRARIES}"
#  "${BridgeNumPyTests}")

#itk_add_test(NAME itkPyBufferTest
#  COMMAND BridgeNumPyTestDriver itkPyBufferTest)
message("+++++++++" ${CMAKE_CURRENT_SOURCE_DIR})
if(ITK_WRAP_PYTHON)
  itk_python_add_test(NAME DicomSliceReadPythonTest
                      COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/itkPyBufferTest.py
                     )
endif()
