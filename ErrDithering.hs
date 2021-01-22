module ErrDithering where
import Image

clamp0Max :: Int -> Int -> Int
clamp0Max x max
    | x > max = max
    | x < 0 = 0
    | otherwise = x

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

multiplyErrMatByScalar :: [[Double]] -> Int -> [[Int]]
multiplyErrMatByScalar matrix scalar = map (map (\x -> floor (x * fromIntegral scalar :: Double))) matrix

calculateNewValue :: Int -> Int -> Int
calculateNewValue curr maxValue
    | curr < ((maxValue `div` 2) + 1) = 0
    | otherwise = maxValue

updateMatrix :: [Rgb] -> Int -> Int -> Int -> [[Int]] -> [[Double]] -> [[Int]]
updateMatrix [x] maxColor col centerCol currErr errMatrix = sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr))) 
    where 
        newValue = clamp0Max (red x + head currErr !! col) maxColor
        newErrMatrix = multiplyErrMatByScalar errMatrix (newValue - calculateNewValue newValue maxColor)
updateMatrix (x:xs) maxColor col centerCol currErr errMatrix = updateMatrix xs maxColor (col + 1) centerCol (sumMatrix currErr (fitWithZeros newErrMatrix col centerCol (length (head currErr)))) errMatrix
    where
        newValue = clamp0Max (red x + head currErr !! col) maxColor
        newErrMatrix = multiplyErrMatByScalar errMatrix (newValue - calculateNewValue newValue maxColor)

updateRGBMatrix :: [[Rgb]] -> Int -> Int -> Int -> [[Int]] -> [[Double]] -> [[Rgb]]
updateRGBMatrix [row] maxColor centerCol rowIndex initialErrMatrix errMatrix = newRow
    where
        newRow = [[rgbFromInt (calculateNewValue (clamp0Max (red (row !! col) + (head initialErrMatrix !! col)) maxColor) maxColor) | col <- [0..length row - 1]]]
updateRGBMatrix (row:remaining) maxColor centerCol rowIndex initialErrMatrix errMatrix = newRow : updateRGBMatrix 
                                                                                                    remaining 
                                                                                                    maxColor 
                                                                                                    centerCol 
                                                                                                    (rowIndex + 1) 
                                                                                                    (removeFirstAndAppend updatedErr (replicate (length (head updatedErr)) 0)) 
                                                                                                    errMatrix
    where
        newRow = [rgbFromInt (calculateNewValue (clamp0Max (red (row !! col) + (head updatedErr !! col)) maxColor) maxColor) | col <- [0..length row - 1]]
        updatedErr = updateMatrix row maxColor 0 centerCol initialErrMatrix errMatrix

applyErrDithering :: Image -> Int -> [[Double]] -> Image
applyErrDithering (Image width height maxColor content) centerCol errMatrix = Image 
                                                                        width 
                                                                        height 
                                                                        maxColor 
                                                                        (updateRGBMatrix 
                                                                            content
                                                                            maxColor
                                                                            centerCol
                                                                            0
                                                                            (zeroesMatrix (length errMatrix) (length (head content)))
                                                                            errMatrix
                                                                        )

removeFirstAndAppend :: [[a]] -> [a] -> [[a]]
removeFirstAndAppend m r = tail m ++ [r]

zeroesMatrix :: Int -> Int -> [[Int]]
zeroesMatrix rows cols = [replicate cols 0 | r <- [1..rows]]