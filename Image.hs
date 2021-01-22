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
convertRGBtoGrayscale (Rgb red green blue) = let grayscale = (maximum [red, green, blue] + minimum [red, green, blue]) `div` 2
                                             in Rgb grayscale grayscale grayscale

imageToString :: [[Rgb]] -> [String]
imageToString strs = [pixelToString px | px <- concat strs]
      
rgbFromInt :: Int -> Rgb
rgbFromInt value = Rgb value value value

pixelToString :: Rgb -> String 
pixelToString (Rgb red green blue) = show red ++ " " ++ show green ++ " " ++ show blue

calculateNewValue :: Int -> Int -> Int
calculateNewValue curr maxValue
    | curr < ((maxValue `div` 2) + 1) = 0
    | otherwise = maxValue

clamp0Max :: Int -> Int -> Int
clamp0Max x max
    | x > max = max
    | x < 0 = 0
    | otherwise = x