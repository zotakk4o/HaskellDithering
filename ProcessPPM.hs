module ProcessPPM (savePPM, loadPPM) where 
import Image
import Data.Word ( Word8 )

textToImage :: String -> [String] -> Int -> Int -> Word8 -> [[Rgb]] -> [Rgb] -> Image
textToImage format [] width height maxColor content currentContent
  | not (null currentContent) = Image width height maxColor (tail content ++ [currentContent])
  | otherwise = Image width height maxColor (tail content)
textToImage format (x : y : z : remainingContent) width height maxColor content currentContent
  | x == format = textToImage 
                    format
                    (tail remainingContent)
                    (read y :: Int)
                    (read z :: Int)
                    (read (head remainingContent) :: Word8)
                    content
                    currentContent
  | otherwise =
    if length currentContent == width
      then 
          textToImage
            format
            remainingContent 
            width 
            height
            maxColor 
            (content ++ [currentContent]) 
            [convertRGBtoGrayscale (Rgb (read x :: Word8) (read y :: Word8) (read z :: Word8))]
      else 
          textToImage 
            format
            remainingContent 
            width 
            height
            maxColor
            content
            (currentContent ++ [convertRGBtoGrayscale (Rgb (read x :: Word8) (read y :: Word8) (read z :: Word8))])

savePPM :: FilePath -> Image -> IO ()
savePPM path (Image width height maxColor content) =
  writeFile path (unlines (["P3", show width, show height, show maxColor] ++ imageToString content))
  

loadPPM :: String -> IO Image
loadPPM path = do
    content <- readFile path
    return (textToImage "P3" (words content) 0 0 0 [[]] [])