module Main where
import InputValidator
import FSD
import Messages
import ProcessPPM
import ProcessPGM
import ProcessPBM
import Helpers
import Debug.Trace
import Image ( imageToString, Image(content) )
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
                        case algoChoice of
                            "2" -> do
                                image <- if isPPM inputFileName then loadPPM (split inputFileName ' ' !! 1) else loadPGM (split inputFileName ' ' !! 1)
                                (if isPPM outputFileName then
                                    savePPM (split outputFileName ' ' !! 1) (applyFSD image)
                                else
                                    (if isPGM outputFileName then
                                        savePGM (split outputFileName ' ' !! 1) (applyFSD image)
                                    else
                                        savePBM (split outputFileName ' ' !! 1) (applyFSD image)))
                    else 
                        putStrLn incorrectChoice
            else
                putStrLn incorrectOutputFilename

    else
        putStrLn incorrectInputFilename