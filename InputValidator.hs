module InputValidator where
import Data.List
import Helpers

isFileValid :: String -> Bool
isFileValid [] = False
isFileValid name
    | isPBM name || isPGM name || isPPM name = True
    | otherwise = False

isCommandValid :: String -> Char -> Bool
isCommandValid [] _ = False
isCommandValid cmd@(x:xs) op
    | x == op && not (null xs) && (head xs) == ' ' && not (null (tail xs)) && isFileValid (tail xs) = True
    | op == 'n' && not (isNumber cmd) = False
    | let choice = strToInt cmd in op == 'n' && choice < 1 || choice > 11 = True
    | otherwise = False

