import Control.Monad

main = do
    t <- readLn
    replicateM_ t $ do
        line <- getLine
        let ([r, g, y, b], balRG, balYB) = foldl check ([0, 0, 0, 0], True, True) line
        print $ r == g && balRG && y == b && balYB

check ([r, g, y, b], balRG, balYB) ch = (res, abs (r'-g') <= 1 && balRG, abs (y'-b') <= 1 && balYB)
    where res@[r', g', y', b'] = case ch of 'R' -> [r+1, g, y, b]
                                            'G' -> [r, g+1, y, b]
                                            'Y' -> [r, g, y+1, b]
                                            'B' -> [r, g, y, b+1] 
