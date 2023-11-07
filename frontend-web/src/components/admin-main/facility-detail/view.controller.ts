import { AdminFacilityDetailViewModel } from "@components/admin-main/facility-detail/view.model.ts";
import React, { useCallback, useEffect, useState } from "react";
import { usePathId } from "@hooks/use-path-id.ts";
import { denyFacility } from "@api/auth/admin.ts";
import { useNavigate } from "react-router-dom";

export const useAdminFacilityDetailViewController = () => {
  AdminFacilityDetailViewModel.use();

  const [approvalDialogOpen, setApprovalDialogOpen] = useState<boolean>(false);
  const [rejectionDialogOpen, setRejectionDialogOpen] = useState<boolean>(false);
  const [rejectionReason, setRejectionReason] = useState<string>("");

  const { getState, fetch } = AdminFacilityDetailViewModel;
  const { facilityDetail, isLoading } = getState();

  const navigate = useNavigate();

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
    denyFacility(facilityId, true).finally(() => {
      setApprovalDialogOpen(false);
      navigate("/admin");
    });
  }, [facilityId, navigate]);

  const onClickOkayOnRejectionDialog = useCallback(() => {
    denyFacility(facilityId, false).finally(() => {
      setRejectionDialogOpen(false);
      setRejectionReason("");
      navigate("/admin");
    });
  }, [facilityId, navigate]);

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
