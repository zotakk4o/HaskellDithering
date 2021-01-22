module BayerDithering where
import Image
import Helpers

updateRGBMatrix :: [[Rgb]] -> Int -> Int -> [[Double]] -> [[Rgb]]
updateRGBMatrix [row] maxColor rowIndex bayerMatrix = [[calculateNewValueByBayerMatrix (row !! col) (rowIndex, col) maxColor bayerMatrix | col <- [0..length row - 1]]]
updateRGBMatrix (row:remaining) maxColor rowIndex bayerMatrix = newRow : updateRGBMatrix remaining maxColor (rowIndex + 1) bayerMatrix
    where
        newRow = [calculateNewValueByBayerMatrix (row !! col) (rowIndex, col) maxColor bayerMatrix | col <- [0..length row - 1]]

calculateNewValueByBayerMatrix :: Rgb -> (Int, Int) -> Int -> [[Double]] -> Rgb
calculateNewValueByBayerMatrix currRgb (row, col) maxColor bayerMatrix = let
                                                                value = red currRgb
                                                                ratio = (fromIntegral value :: Double) / (fromIntegral maxColor :: Double)
                                                                bayerSize = length bayerMatrix
                                                                bayerRatio = bayerMatrix !! mod row bayerSize !! mod col bayerSize
                                                                in if ratio > bayerRatio then rgbFromInt maxColor else rgbFromInt 0

applyBayerDithering :: Image -> [[Double]] -> Image
applyBayerDithering (Image width height maxColor content) bayerMatrix = Image width height maxColor (updateRGBMatrix content maxColor 0 bayerMatrix)