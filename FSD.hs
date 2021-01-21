module FSD where
import Prelude
import Image
import ErrorsTables
import Debug.Trace
getErrMatrix :: Int -> [[Int]]
getErrMatrix err = map (map (\x -> fromIntegral x * (err `div` fsdDenominator) )) fsd

fitWithZeros :: [[Int]] -> Int -> Int -> Int -> [[Int]]
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

sumMatrix :: [[Int]] -> [[Int]] -> [[Int]]
sumMatrix [[]] b = b
sumMatrix a [[]] = a
sumMatrix a b = zipWith (zipWith (+)) a b

calculateNewValue :: Int -> Int -> Int
calculateNewValue curr maxValue = ( curr `div` (maxValue `div` 2)) * maxValue

updateMatrix :: [Rgb] -> Int -> Int -> Int -> [[Int]] -> [[Int]]
updateMatrix [x] maxColor col centerCol currErr = sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr))) 
    where 
        newValue = red x + head currErr !! col
        newErrMatrix = getErrMatrix (red x - calculateNewValue newValue maxColor)
updateMatrix (x:xs) maxColor col centerCol currErr = updateMatrix xs maxColor (col + 1) centerCol (sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr)))) 
    where
        newValue = red x + head currErr !! col 
        newErrMatrix = getErrMatrix (red x - calculateNewValue newValue maxColor)

updateRGBMatrix :: [[Rgb]] -> Int -> Int -> Int -> [[Int]] -> [[Rgb]]
updateRGBMatrix [row] maxColor centerCol rowIndex initialErrMatrix = newRow
    where newRow = [[rgbFromInt (abs (((red (row !! col) + (initialErrMatrix !! mod rowIndex (length initialErrMatrix) !! col)) `div`  (maxColor `div` 2) ) * maxColor)) | col <- [0..length row - 1]]]
updateRGBMatrix (row:remaining) maxColor centerCol rowIndex initialErrMatrix = newRow : updateRGBMatrix remaining maxColor centerCol (rowIndex + 1) (drop 1 updatedErr ++ [replicate (length (head updatedErr)) 0])
    where newRow = [rgbFromInt (abs (((red (row !! col) + (updatedErr !! mod rowIndex (length updatedErr) !! col)) `div` (maxColor `div` 2)) * maxColor)) | col <- [0..length row - 1]]
          updatedErr = updateMatrix row maxColor 0 centerCol initialErrMatrix

applyFSD :: Image -> Image 
applyFSD (Image width height maxColor content) = Image width height maxColor (updateRGBMatrix content maxColor fsdCenterCol (-1) [replicate (length (head content)) 0, replicate (length (head content)) 0])