import { AdminExpertDetailViewModel } from "@components/admin-main/expert-detail/view.model.ts";
import React, { useCallback, useEffect, useState } from "react";

export const useAdminExpertDetailViewController = () => {
  AdminExpertDetailViewModel.use();

  const [approvalDialogOpen, setApprovalDialogOpen] = useState<boolean>(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState<boolean>(false);
  const [rejectionReason, setRejectionReason] = useState<string>("");

  // const expertId = useLoaderData();

  const { getState, fetch } = AdminExpertDetailViewModel;
  const { expertDetail, isLoading } = getState();

  useEffect(() => {
    fetch();
    // fetch(expertId);
  }, [fetch]);

  const openApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(true);
  }, [setApprovalDialogOpen]);

  const openRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(true);
  }, [setRejectionDialogOpen]);

  const onCloseApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(false);
  }, [setApprovalDialogOpen]);

  const onCloseRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(false);
    setRejectionReason("");
  }, [setRejectionDialogOpen]);

  const onClickOkayOnApprovalDialog = useCallback(() => {
    setApprovalDialogOpen(false);
  }, [setApprovalDialogOpen]);

  const onClickOkayOnRejectionDialog = useCallback(() => {
    setRejectionDialogOpen(false);
    setRejectionReason("");
  }, [setRejectionDialogOpen]);

  const onChangeRejectionReason = useCallback(
    (event: React.ChangeEvent<HTMLTextAreaElement>) => {
      setRejectionReason(event.target.value);
    },
    [setRejectionReason],
  );

  return {
    expertDetail,
    isLoading,
    openApprovalDialog,
    approvalDialogOpen,
    onCloseApprovalDialog,
    onClickOkayOnApprovalDialog,
    openRejectionDialog,
    rejectionDialogOpen,
    onCloseRejectionDialog,
    onClickOkayOnRejectionDialog,
    rejectionReason,
    onChangeRejectionReason,
  };
};
