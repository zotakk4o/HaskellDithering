module ProcessPBM where
import Image

saveImage :: FilePath -> Image -> IO ()
saveImage path (Image width height content) =
  writeFile path (unlines (["P2", show width, show height] ++ imageToString content))