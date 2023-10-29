import { AdminExpertDetailViewModel } from "@components/admin-main/expert-detail/view.model.ts";
import { useEffect } from "react";

export const useAdminExpertDetailViewController = () => {
  AdminExpertDetailViewModel.use();

  // const expertId = useLoaderData();

  const { getState, fetch } = AdminExpertDetailViewModel;
  const { expertDetail, isLoading } = getState();

  useEffect(() => {
    fetch();
    // fetch(expertId);
  }, [fetch]);

  return { expertDetail, isLoading };
};
