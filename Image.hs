module Image where
import Data.Word (Word8)

data Rgb = Rgb
  { red :: Word8,
    green :: Word8,
    blue :: Word8
  }
  deriving (Show, Read)

data Image = Image
  { width :: Int,
    height :: Int,
    maxColor :: Word8,
    content :: [[Rgb]]
  }
  deriving (Show, Read)

convertRGBtoGrayscale :: Rgb -> Rgb
convertRGBtoGrayscale (Rgb red green blue) = let grayscale =
                                                     round (0.3 * toRational red + 
                                                            0.59 * toRational green + 
                                                            0.11 * toRational blue)
                                             in Rgb grayscale grayscale grayscale

imageToString :: [[Rgb]] -> [String]
imageToString strs = [pixelToString px | px <- concat strs]
      
rgbFromWord8 :: Word8 -> Rgb
rgbFromWord8 value = Rgb value value value

pixelToString :: Rgb -> String 
pixelToString (Rgb red green blue) = show red ++ " " ++ show green ++ " " ++ show blue
