module ProcessPGM (savePGM, loadPGM) where
import Image
import Data.Word ( Word8 )
import Debug.Trace

textToImage :: String -> [String] -> Int -> Int -> Word8 -> [[Rgb]] -> [Rgb] -> Image
textToImage format [] width height maxColor content currentContent
  | not (null currentContent) = Image width height maxColor (tail content ++ [currentContent])
  | otherwise = Image width height maxColor (tail content)
textToImage format (x:remainingContent) width height maxColor content currentContent
  | x == format = textToImage 
                    format
                    (tail (tail (tail remainingContent)))
                    (read (head remainingContent) :: Int)
                    (read (head (tail remainingContent)) :: Int)
                    (read (head (tail (tail remainingContent))) :: Word8)
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
            [rgbFromWord8 (read x :: Word8)]
      else 
          textToImage 
            format
            remainingContent 
            width 
            height
            maxColor
            content
            (currentContent ++ [rgbFromWord8 (read x :: Word8)])

savePGM :: FilePath -> Image -> IO ()
savePGM path (Image width height maxColor content) =
    writeFile path (unlines (["P2", show width, show height, show maxColor] ++ imageToString content))

loadPGM :: String -> IO Image
loadPGM path = do
    content <- readFile path
    return (textToImage "P2" (words content) 0 0 0 [[]] [])