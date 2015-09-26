main = do
    la <- getLine >> getLine 
    lb <- getLine >> getLine
    let fa = map (\x -> read x :: Integer) $ words la
        fb = map (\x -> read x :: Integer) $ words lb
        pa = foldl (*) 1 fa
        pb = foldl (*) 1 fb
    print $ gcd pa pb `mod` 1000000007
    return ()
