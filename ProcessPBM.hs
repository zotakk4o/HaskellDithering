module ProcessPBM (savePBM) where
import Image hiding(imageToString)

imageToString :: [[Rgb]] -> [String]
imageToString strs = [ show (red x) | x <- concat strs]

savePBM :: FilePath -> Image -> IO ()
savePBM path (Image width height maxColor content) =
  writeFile path (unlines (["P2", show width, show height] ++ imageToString content))