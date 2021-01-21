module FSD where
import Prelude
import Image
import Data.Word
import ErrorsTables
import Debug.Trace
getErrMatrix :: Word8 -> [[Word8]]
getErrMatrix err = map (map (\x -> fromIntegral x * round (fromIntegral err / fromIntegral fsdDenominator) )) fsd

fitWithZeros :: [[Word8]] -> Int -> Int -> Int -> [[Word8]]
fitWithZeros [[]] _ _ _ = [[]]
fitWithZeros curr col centerCol targetNum =  [replicate ((targetNum - max 0 elementsAfterCurrRow) - length reducedRow) 0 
                                             ++ reducedRow  
                                             ++ replicate elementsAfterCurrRow 0 | row <- curr,
                                             let 
                                                 elementsAfterCenterCol = (length row - 1) - centerCol
                                                 elementsAfterCurrRow = ((targetNum - 1) - col) - elementsAfterCenterCol
                                                 reducedRow = removeNColsEnd (drop (centerCol - col) row) (col - ((targetNum - 1) - elementsAfterCenterCol))]

removeNColsEnd :: [a] -> Int -> [a]
removeNColsEnd [] _ = []
removeNColsEnd row n = take (length row - n) row

sumMatrix :: [[Word8]] -> [[Word8]] -> [[Word8]]
sumMatrix [[]] b = b
sumMatrix a [[]] = a
sumMatrix a b = zipWith (zipWith (+)) a b

calculateNewValue :: Word8 -> Word8 -> Word8
calculateNewValue curr maxValue = round (fromIntegral curr / fromIntegral maxValue) * maxValue

updateMatrix :: [Rgb] -> Word8 -> Int -> Int -> [[Word8]] -> [[Word8]]
updateMatrix [x] maxColor col centerCol currErr = sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr))) 
    where newErrMatrix = getErrMatrix (red x - calculateNewValue (red x) maxColor)
updateMatrix (x:xs) maxColor col centerCol currErr = updateMatrix xs maxColor (col + 1) centerCol (sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr)))) 
    where newErrMatrix = getErrMatrix (red x - calculateNewValue (red x) maxColor)

updateRGBMatrix :: [[Rgb]] -> Word8 -> Int -> Int -> [[Word8]] -> [[Rgb]]
updateRGBMatrix matrix maxColor centerCol (-1) initialErrMatrix = updateRGBMatrix matrix maxColor centerCol 0 (updateMatrix (head matrix) maxColor 0 centerCol initialErrMatrix)
updateRGBMatrix [row] maxColor centerCol rowIndex initialErrMatrix = [[rgbFromWord8 (initialErrMatrix !! mod rowIndex (length initialErrMatrix) !! col) | col <- [0..length row - 1]]]
updateRGBMatrix (row:remaining) maxColor centerCol rowIndex initialErrMatrix = newRow : updateRGBMatrix remaining maxColor centerCol (rowIndex + 1) (updateMatrix row maxColor 0 centerCol initialErrMatrix)
    where newRow = [rgbFromWord8 (initialErrMatrix !! mod rowIndex (length initialErrMatrix) !! col) | col <- [0..length row - 1]]

applyFSD :: Image -> Image 
applyFSD (Image width height maxColor content) = Image width height maxColor (updateRGBMatrix content maxColor fsdCenterCol (-1) [replicate (length (head content)) 0, replicate (length (head content)) 0])