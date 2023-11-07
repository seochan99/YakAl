import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

export function useLoginPageViewController() {
  const navigate = useNavigate();

  useEffect(() => {
    ExpertUserViewModel.fetch();
  }, [navigate]);
}
