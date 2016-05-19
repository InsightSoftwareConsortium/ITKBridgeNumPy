
%pythoncode %{

HAVE_NUMPY = True
try:
  import numpy
except ImportError:
  HAVE_NUMPY = False


class itkndarray(numpy.ndarray):
    """ A customized NumPy.ndarray for ITK Image."""

    bConverted = False

    def SetConvertedFlag(self, converted = True):
        self.bConverted = converted

    def __setitem__(self, item, to):
        if self.bConverted == True:
            temp            = numpy.array(self, copy = True)
            self.data       = temp.data
            self.bConverted = False
        super(itkndarray, self).__setitem__(item, to)

    def itemset(self, *args):
        if self.bConverted == True:
            temp            = numpy.array(self, copy = True)
            self.data       = temp.data
            self.bConverted = False
        super(itkndarray, self).itemset(*args)

%}

%extend itkPyBufferIF2{
    %pythoncode %{

    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferIF2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.float32).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferIF2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferIF2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)

  %}
};


%extend itkPyBufferIF3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferIF3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.float32).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferIF3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferIF3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferISS2{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferISS2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.int16).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferISS2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferISS2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferISS3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferISS3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.int16).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferISS3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferISS3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferIUC2{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferIUC2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.uint8).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferIUC2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferIUC2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferIUC3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferIUC3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.uint8).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferIUC3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferIUC3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferVIF2{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVIF2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.float32).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVIF2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVIF2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
   %}
};

%extend itkPyBufferVIF3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVIF3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.float32).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVIF3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVIF3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferVISS2{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVISS2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.int16).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVISS2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVISS2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};


%extend itkPyBufferVISS3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVISS3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.int16).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVISS3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVISS3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferVIUC2{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVIUC2._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.uint8).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVIUC2._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVIUC2._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};

%extend itkPyBufferVIUC3{
  %pythoncode %{
    def GetArrayFromImage(image, keepAxes=False):
        """  Get a NumPy array from a ITK Image.  """
   
        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        itksize = image.GetLargestPossibleRegion().GetSize()
        dim     = len(itksize)
        shape   = []
        for idx in range(dim):
            shape.append(int(itksize[idx]))

        if(image.GetNumberOfComponentsPerPixel() > 1):
            shape = [image.GetNumberOfComponentsPerPixel(), ] + shape

        if keepAxes == False:
            shape = shape[::-1]

        memview      = itkPyBufferVIUC3._GetArrayFromImage(image, keepAxes)
        itkndarrview = numpy.asarray(memview).view(dtype = numpy.uint8).reshape(shape).view(itkndarray)
        itkndarrview.SetConvertedFlag(converted = True)

        return itkndarrview

    GetArrayFromImage = staticmethod(GetArrayFromImage)

    def GetImageFromArray(ndarr, isVector=False):
        """ Get an ITK Image from a NumPy array.
            If isVector is True, then a 3D array will be treated as a 2D vector image,
            otherwise it will be treated as a 3D image """

        if not HAVE_NUMPY:
            raise ImportError('Numpy not available.')

        assert ndarr.ndim in ( 2, 3, 4 ), \
            "Only arrays of 2, 3 or 4 dimensions are supported."

        if ( ndarr.ndim == 3 and isVector ) or (ndarr.ndim == 4):
            imgview = itkPyBufferVIUC3._GetImageFromArray( ndarr, ndarr.shape[-2::-1], ndarr.shape[-1] )
        elif ndarr.ndim in ( 2, 3 ):
            imgview = itkPyBufferVIUC3._GetImageFromArray( ndarr, ndarr.shape[::-1], 1)

        return imgview

    GetImageFromArray = staticmethod(GetImageFromArray)
  %}
};