import { projects } from '$lib/server/oss'
import { publications } from '$lib/server/papers'

export const load = () => ({ projects, publications })
