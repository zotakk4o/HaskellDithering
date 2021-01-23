module Main where
import InputValidator
import Messages
import DitheringProcessor
import Helpers
import ProcessPPM
import ProcessPGM

main :: IO ()
main = do
    putStrLn welcome
    putStrLn enterInput
    inputFileName <- getLine
    if isCommandValid inputFileName 'i' then
        do
            putStrLn enterOutput
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
                                "10" -> do applyBayerFourByFour outputFileName image
                                "11" -> do applyBayerEightByEight outputFileName image
                                
                            putStrLn success
                                    
                    else 
                        putStrLn incorrectChoice
            else
                putStrLn incorrectOutputFilename

    else
        putStrLn incorrectInputFilename
