import Data.Csv
import qualified Data.Vector as V
import qualified Data.Map as Map
import qualified Data.Set as Set
import Control.Monad
import qualified Data.ByteString.Lazy as B
import Census 

merge :: Ord k => Map.Map k a -> Map.Map k b -> Map.Map k (Maybe a, Maybe b)
merge as bs =
  Map.fromAscList $ map (\k -> (k, (Map.lookup k as, Map.lookup k bs))) $ Set.toAscList $ (Map.keysSet as) `Set.union` (Map.keysSet bs)

main :: IO ()
main =  do
  geoContents <- B.readFile "scc_geo_2010_sorted.csv" 
  popContents <- B.readFile "scc_population_2010_sorted.csv"
  workContents <- B.readFile "scc_work_2010_sorted.csv"
  case (decode NoHeader geoContents, decode NoHeader popContents, decode NoHeader workContents) of 
    (Right gs, Right ps, Right ws) -> B.putStr $ encode $ map mergeField $ Map.toAscList $ merge (Map.fromAscList $ map gkv $V.toList gs) $ merge (Map.fromAscList $ map pkv $V.toList ps) (Map.fromAscList $ map wkv $ V.toList ws)
                                      where
                                        mergeField (k, (g, pw)) = (k, lon, lat, p', w')
                                          where
                                            (lon,lat) = case g of 
                                                          Just (lon',lat') -> (lon',lat')
                                                          Nothing          -> (0,0)
                                            p' = case pw of 
                                                   Just (Just p, _) -> p
                                                   _                -> 0
                                            w' = case pw of
                                                   Just (_,Just w) -> w
                                                   _               -> 0
                                        gkv :: (Int, Int, Int, Int, Int, String, String, String, String, String, String, Int, Int, Double, Double) -> (Int, (Double,Double))
                                        gkv (_,_,_,_,id,_,_,_,_,_,_,_,_,lon,lat) = (id,(lon,lat))
                                        pkv :: (String, String, Int) -> (Int,Int)
                                        pkv (id,_,pop) = ((read $ drop 9 id) :: Int, pop)
                                        wkv :: [Int]-> (Int,Int)
                                        wkv (id : work : ws) = (id,work)
    (g,p,w)                       -> print $ errormsg g ++ errormsg p ++ errormsg w where
                                       errormsg a = case a of 
                                         Left gerror' -> gerror'
                                         _            -> ""
  
