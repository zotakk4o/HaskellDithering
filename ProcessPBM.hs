module ProcessPBM (savePBM) where
import Image hiding(imageToString)

convertToPBM :: Int -> Int -> Int
convertToPBM x maxColor
  | x == maxColor = 0
  | otherwise = 1

imageToString :: [[Rgb]] -> Int -> [String]
imageToString strs maxColor = [ show (convertToPBM (red x) maxColor) | x <- concat strs]

savePBM :: FilePath -> Image -> IO ()
savePBM path (Image width height maxColor content) =
  writeFile path (unlines (["P1", show width, show height] ++ imageToString content maxColor))