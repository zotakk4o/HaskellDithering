module Image where

data Rgb = Rgb
  { red :: Int,
    green :: Int,
    blue :: Int
  }
  deriving (Show, Read)

data Image = Image
  { width :: Int,
    height :: Int,
    maxColor :: Int,
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
      
rgbFromInt :: Int -> Rgb
rgbFromInt value = Rgb value value value

pixelToString :: Rgb -> String 
pixelToString (Rgb red green blue) = show red ++ " " ++ show green ++ " " ++ show blue
