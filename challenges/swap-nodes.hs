import Control.Monad

data Tree = Leaf | Tree {root :: Int, left :: Tree, right :: Tree}

instance Show Tree where
    show Leaf = ""
    show t = (show (left t)) ++ ((show (root t)) ++ " ") ++ (show (right t))

main = do
    n <- readLn
    children <- mapM (\_ -> fmap (map read . words) getLine) [1..n]
    t <- readLn
    ks <- mapM (\_ -> readLn) [1..t]
    let tree = toTree 1 children
    swaps tree ks

toTree (-1) children = Leaf
toTree i children = Tree { root = i, left = toTree l children, right = toTree r children }
    where [l, r] = children !! (i-1)

swap _ Leaf _ = Leaf
swap h tree k 
    | h == k = Tree { root = v, left = swap 1 r k, right = swap 1 l k }
    | otherwise = Tree { root = v, left = swap (h+1) l k, right = swap (h+1) r k }
    where v = root tree
          l = left tree
          r = right tree

swaps _ [] = return ()
swaps tree (k:ks) = print tree' >> swaps tree' ks
    where tree' = swap 1 tree k
