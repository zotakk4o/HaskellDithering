module DitheringProcessor where
import Helpers
import ErrDithering (applyErrDithering)
import BayerDithering (applyBayerDithering)
import ErrorsTables
import Image ( imageToString, Image(content) )
import ProcessPPM
import ProcessPGM
import ProcessPBM

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

applyBayerFourByFour :: String -> Image -> IO ()
applyBayerFourByFour outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
      (applyBayerDithering image bayerFourByFour)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
       (applyBayerDithering image bayerFourByFour)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
       (applyBayerDithering image bayerFourByFour)

applyBayerEightByEight :: String -> Image -> IO ()
applyBayerEightByEight outputFileName image
  | isPPM outputFileName
  = savePPM
      (split outputFileName ' ' !! 1)
       (applyBayerDithering image bayerEightByEight)
  | isPGM outputFileName
  = savePGM
      (split outputFileName ' ' !! 1)
       (applyBayerDithering image bayerEightByEight)
  | otherwise
  = savePBM
      (split outputFileName ' ' !! 1)
       (applyBayerDithering image bayerEightByEight)