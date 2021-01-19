module Main where
import InputValidator
import Messages
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
                        putStrLn success
                    else
                        putStrLn incorrectChoice
            else
                putStrLn incorrectOutputFilename

    else
        putStrLn incorrectInputFilename