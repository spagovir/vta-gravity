import Data.Csv
import Data.Vector (Vector)
import qualified Data.Map as Map
import qualified Data.Set as Set
import Control.Monad
import System.IO

merge :: Ord k => Map.Map k a -> Map.Map k b -> Map.Map k (Maybe a, Maybe b)
merge as bs =
  Map.fromAscList $ map (\k -> (k, (Map.lookup k as, Map.lookup k bs))) $ Set.toAscList $ (Map.keysSet as) `Set.union` (Map.keysSet bs)

main :: IO ()
main = 
