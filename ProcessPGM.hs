module ProcessPGM where
import Image

saveImage :: FilePath -> Image -> IO ()
saveImage path (Image width height content) =
  writeFile path (unlines (["P2", show width, show height, "255"] ++ imageToString content))

loadImage :: String -> IO Image
loadImage path = do
    content <- readFile path
    return (textToImage "P2" (words content) 0 0  [[]] [])