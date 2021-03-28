{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_vta_gravity (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/bin"
libdir     = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/lib/x86_64-linux-ghc-8.10.4/vta-gravity-0.0.0-6Lo1Z89dTRzEsyLl9yyxtw"
dynlibdir  = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/share/x86_64-linux-ghc-8.10.4/vta-gravity-0.0.0"
libexecdir = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/libexec/x86_64-linux-ghc-8.10.4/vta-gravity-0.0.0"
sysconfdir = "/root/vta-gravity/.stack-work/install/x86_64-linux/7805ebca87e70e756212f36d5742723acc2fe8a70a6fe82ddbe2377a30578418/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "vta_gravity_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "vta_gravity_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "vta_gravity_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "vta_gravity_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "vta_gravity_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "vta_gravity_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
