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
    content :: [[Rgb]]
  }
  deriving (Show, Read)

convertRGBtoGrayscale :: Rgb -> Rgb
convertRGBtoGrayscale (Rgb red green blue) = let grayscale =
                                                     round (0.3 * toRational red + 
                                                            0.59 * toRational green + 
                                                            0.11 * toRational blue)
                                             in Rgb grayscale grayscale grayscale

rgbToString :: Rgb -> String
rgbToString (Rgb red green blue) = show red ++ " " ++ show green ++ " " ++ show blue

imageToString :: [[Rgb]] -> [String]
imageToString strs = [rgbToString x | x <- concat strs]

textToImage :: String -> [String] -> Int -> Int -> [[Rgb]] -> [Rgb] -> Image
textToImage format [] width height content currentContent
  | not (null currentContent) = Image width height (tail content ++ [currentContent])
  | otherwise = Image width height (tail content)
textToImage format (x : y : z : remainingContent) width height content currentContent
  | x == format = textToImage format (tail remainingContent) (read y :: Int) (read z :: Int) content currentContent
  | otherwise =
    if length currentContent == width
      then 
          textToImage
            format
            remainingContent 
            width 
            height 
            (content ++ [currentContent]) 
            [Rgb (read x :: Word8) (read y :: Word8) (read z :: Word8)]
      else 
          textToImage 
            format
            remainingContent 
            width 
            height 
            content
            (currentContent ++ [Rgb (read x :: Word8) (read y :: Word8) (read z :: Word8)])