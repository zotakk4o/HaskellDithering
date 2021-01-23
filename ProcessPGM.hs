module ProcessPGM (savePGM, loadPGM) where
import Image hiding(imageToString)
import Debug.Trace

textToImage :: String -> [String] -> Int -> Int -> Int -> [[Rgb]] -> [Rgb] -> Image
textToImage format [] width height maxColor content currentContent
  | not (null currentContent) = Image width height maxColor (tail content ++ [currentContent])
  | otherwise = Image width height maxColor (tail content)
textToImage format (x:remainingContent) width height maxColor content currentContent
  | x == format = textToImage 
                    format
                    (tail (tail (tail remainingContent)))
                    (read (head remainingContent) :: Int)
                    (read (head (tail remainingContent)) :: Int)
                    (read (head (tail (tail remainingContent))) :: Int)
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
            [rgbFromInt (read x :: Int)]
      else 
          textToImage 
            format
            remainingContent 
            width 
            height
            maxColor
            content
            (currentContent ++ [rgbFromInt (read x :: Int)])

imageToString :: [[Rgb]] -> [String]
imageToString strs = [show (red px) | px <- concat strs]

savePGM :: FilePath -> Image -> IO ()
savePGM path (Image width height maxColor content) =
    writeFile path (unlines (["P2", show width, show height, show maxColor] ++ imageToString content))

loadPGM :: String -> IO Image
loadPGM path = do
    content <- readFile path
    return (textToImage "P2" (words content) 0 0 0 [[]] [])