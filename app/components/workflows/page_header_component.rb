# frozen_string_literal: true

# -- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2010-2024 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
# ++

module Workflows
  class PageHeaderComponent < ApplicationComponent
    include OpPrimer::ComponentHelpers
    include ApplicationHelper

    def initialize(state:)
      super
      @state = state
    end

    def breadcrumb_items
      base_items = [{ href: admin_index_path, text: t("label_administration") },
                    { href: admin_settings_work_package_tracking_path, text: t(:label_work_package_plural) },
                    title]

      if @state == :edit
        base_items
      else
        base_items.insert(2, { href: edit_workflows_path, text: t(:label_workflow_plural) })
      end
    end

    def title
      case @state
      when :show
        t(:label_workflow_summary)
      when :copy
        t(:label_workflow_copy)
      when :edit
        Workflow.model_name.human
      else
        t(:label_workflow_plural)
      end
    end
  end
end
