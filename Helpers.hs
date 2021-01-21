module Helpers where
import Data.Char ( isDigit )
import Data.List

strToInt :: String -> Int
strToInt [] = 0
strToInt str = read str :: Int

isNumber :: String -> Bool
isNumber ""  = False
isNumber "." = False
isNumber xs  =
  case dropWhile isDigit xs of
    ""       -> True
    ('.':ys) -> all isDigit ys
    _        -> False

isPPM :: String -> Bool
isPPM [] = False 
isPPM str = isSuffixOf ".ppm" str

isPGM :: String -> Bool
isPGM [] = False 
isPGM str = isSuffixOf ".pgm" str

isPBM :: String -> Bool
isPBM [] = False 
isPBM str = isSuffixOf ".pbm" str

split :: String -> Char -> [String]
split [] _ = []
split str c = newStr : split (drop (length newStr + 1) str) c 
    where newStr = takeWhile (/= c) str