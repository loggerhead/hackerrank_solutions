main :: IO()
main = do
       str <- getLine 
       putStrLn (reverse (foldl (\l ch -> if ch `elem` l then l else ch:l ) [] str))
