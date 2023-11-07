import { useLocation } from "react-router-dom";

export function usePathId() {
  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  return +location.pathname.substring(lastSlashIndex + 1);
}
