import { OSS_SORT_KEYS, type Project } from './types'

export type OssSortKey = (typeof OSS_SORT_KEYS)[keyof typeof OSS_SORT_KEYS]
export type SortOrder = `asc` | `desc`

export const oss_sort_keys = [
  { value: OSS_SORT_KEYS.commits, tooltip: `Sort by commits` },
  { value: OSS_SORT_KEYS.stars, tooltip: `Sort by stars` },
  { value: OSS_SORT_KEYS.name, tooltip: `Sort by name` },
] as const

export function sort_oss_projects<
  ProjectT extends Pick<Project, `name` | `commits` | `stars`>,
>(
  projects: readonly ProjectT[],
  sort_by: OssSortKey,
  sort_order: SortOrder = `desc`,
): ProjectT[] {
  const sort_direction = sort_order === `asc` ? 1 : -1

  return projects.toSorted((project_1, project_2) => {
    if (sort_by === OSS_SORT_KEYS.name) {
      return project_1.name.localeCompare(project_2.name) * sort_direction
    }
    return (project_1[sort_by] - project_2[sort_by]) * sort_direction
  })
}
