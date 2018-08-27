/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.asset.list.service;

import aQute.bnd.annotation.ProviderType;

import com.liferay.portal.kernel.service.ServiceWrapper;

/**
 * Provides a wrapper for {@link AssetListEntryService}.
 *
 * @author Brian Wing Shun Chan
 * @see AssetListEntryService
 * @generated
 */
@ProviderType
public class AssetListEntryServiceWrapper implements AssetListEntryService,
	ServiceWrapper<AssetListEntryService> {
	public AssetListEntryServiceWrapper(
		AssetListEntryService assetListEntryService) {
		_assetListEntryService = assetListEntryService;
	}

	@Override
	public com.liferay.asset.list.model.AssetListEntry addAssetListEntry(
		long userId, long groupId, String title, int type,
		com.liferay.portal.kernel.service.ServiceContext serviceContext)
		throws com.liferay.portal.kernel.exception.PortalException {
		return _assetListEntryService.addAssetListEntry(userId, groupId, title,
			type, serviceContext);
	}

	@Override
	public com.liferay.asset.list.model.AssetListEntry deleteAssetListEntry(
		long assetListEntryId)
		throws com.liferay.portal.kernel.exception.PortalException {
		return _assetListEntryService.deleteAssetListEntry(assetListEntryId);
	}

	@Override
	public com.liferay.asset.list.model.AssetListEntry fetchAssetListEntry(
		long assetListEntryId) {
		return _assetListEntryService.fetchAssetListEntry(assetListEntryId);
	}

	/**
	* Returns the OSGi service identifier.
	*
	* @return the OSGi service identifier
	*/
	@Override
	public String getOSGiServiceIdentifier() {
		return _assetListEntryService.getOSGiServiceIdentifier();
	}

	@Override
	public com.liferay.asset.list.model.AssetListEntry updateAssetListEntry(
		long assetListEntryId, String title)
		throws com.liferay.portal.kernel.exception.PortalException {
		return _assetListEntryService.updateAssetListEntry(assetListEntryId,
			title);
	}

	@Override
	public AssetListEntryService getWrappedService() {
		return _assetListEntryService;
	}

	@Override
	public void setWrappedService(AssetListEntryService assetListEntryService) {
		_assetListEntryService = assetListEntryService;
	}

	private AssetListEntryService _assetListEntryService;
}