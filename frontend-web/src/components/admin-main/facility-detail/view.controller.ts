import { AdminFacilityDetailViewModel } from "@components/admin-main/facility-detail/view.model.ts";
import React, { useCallback, useEffect, useState } from "react";
import { usePathId } from "@hooks/use-path-id.ts";

export const useAdminFacilityDetailViewController = () => {
  AdminFacilityDetailViewModel.use();

  const [approvalDialogOpen, setApprovalDialogOpen] = useState<boolean>(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState<boolean>(false);
  const [rejectionReason, setRejectionReason] = useState<string>("");

  const { getState, fetch } = AdminFacilityDetailViewModel;
  const { facilityDetail, isLoading } = getState();

  const facilityId = usePathId();

  useEffect(() => {
    fetch(facilityId);
  }, [facilityId, fetch]);

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
    facilityDetail,
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
