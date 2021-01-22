module Main where
import InputValidator
import Messages
import ProcessPPM
import ProcessPGM
import ProcessPBM
import Helpers
import ErrDithering
import ErrorsTables
import Image ( imageToString, Image(content) )

applyTDED :: String -> Image -> IO ()
applyTDED outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image tdedCenterCol tded)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image tdedCenterCol tded)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image tdedCenterCol tded)

applyFSD :: String -> Image -> IO ()
applyFSD outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image fsdCenterCol fsd)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image fsdCenterCol fsd)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image fsdCenterCol fsd)
    

applyJJND :: String -> Image -> IO ()
applyJJND outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image jjndCenterCol jjnd)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image jjndCenterCol jjnd)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image jjndCenterCol jjnd)

applyStucki :: String -> Image -> IO ()
applyStucki outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image stuckiCenterCol stucki)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image stuckiCenterCol stucki)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image stuckiCenterCol stucki)

applyAtkinson :: String -> Image -> IO ()
applyAtkinson outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image atkinsonCenterCol atkinson)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image atkinsonCenterCol atkinson)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image atkinsonCenterCol atkinson)

applyBurkes :: String -> Image -> IO ()
applyBurkes outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image burkesCenterCol burkes)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image burkesCenterCol burkes)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image burkesCenterCol burkes)

applySierraOneFourth :: String -> Image -> IO ()
applySierraOneFourth outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneFourthCenterCol sierraOneFourth)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneFourthCenterCol sierraOneFourth)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneFourthCenterCol sierraOneFourth)

applySierraOneSixteenth :: String -> Image -> IO ()
applySierraOneSixteenth outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneSixteenthCenterCol sierraOneSixteenth)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneSixteenthCenterCol sierraOneSixteenth)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneSixteenthCenterCol sierraOneSixteenth)

applySierraOneThirtySecond :: String -> Image -> IO ()
applySierraOneThirtySecond outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneThirtySecondCenterCol sierraOneThirtySecond)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneThirtySecondCenterCol sierraOneThirtySecond)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
      (applyErrDithering image sierraOneThirtySecondCenterCol sierraOneThirtySecond)

main :: IO ()
main = do
    putStrLn welcome
    inputFileName <- getLine
    if isCommandValid inputFileName 'i' then
        do
            outputFileName <- getLine
            if isCommandValid outputFileName 'o' then
                do
                    putStrLn algorithms
                    algoChoice <- getLine
                    if isCommandValid algoChoice 'n' then
                        do 
                            image <- if isPPM inputFileName then loadPPM (split inputFileName ' ' !! 1) else loadPGM (split inputFileName ' ' !! 1)
                            case algoChoice of
                                "1" -> do applyTDED outputFileName image
                                "2" -> do applyFSD outputFileName image
                                "3" -> do applyJJND outputFileName image
                                "4" -> do applyStucki outputFileName image
                                "5" -> do applyAtkinson outputFileName image
                                "6" -> do applyBurkes outputFileName image
                                "7" -> do applySierraOneFourth outputFileName image
                                "8" -> do applySierraOneSixteenth outputFileName image
                                "9" -> do applySierraOneThirtySecond outputFileName image
                                    
                    else 
                        putStrLn incorrectChoice
            else
                putStrLn incorrectOutputFilename

    else
        putStrLn incorrectInputFilename
